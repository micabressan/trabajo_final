# rubocop:disable Rails/Output, AbcSize, ModuleFunction
module Seeder
  extend self

  def run(action)
    report(action) { send(action) }
  end

  def run_all
    (public_instance_methods - [:run, :run_all]).each { |action| run(action) }
  end

  def mycom_publisher
    return if Publisher.find_by_name('MyCom')
    Publisher.create!(
      name: 'MyCom',
      country_code: :US,
      status: :approved,
      owner: User.create!(
        name: 'MyCom owner',
        mycom_id: 0,
        admin: true,
      ),
    )
  end

  def mystore_app
    Mystore.app
  rescue ActiveRecord::RecordNotFound
    setup_factory_girl
    ApkParser.stub(package_name: Mystore::PACKAGE_NAME) do
      FactoryGirl.create(:app, :published,
        publisher: Publisher.find_by_name('MyCom'),
      )
    end
  end

  def mystore_inapps
    app = mystore_app
    EditorTracking.tap(&:testing!).stub(app.publisher.owner) do
      load_file(:mystore_inapps).each do |sku, data|
        next if Inapp.unscoped.find_by(sku: sku)
        data.delete('type').constantize.new(data.merge(app: app, sku: sku, active: true)).
          tap(&:fix_prices).tap(&:save!)
      end
    end
  end

  def users
    load_file(:users).each do |_, data|
      time_freeze 1.month do
        User.create_with(data).find_or_create_by!(email: data['email'])
      end
    end
    User.where(name: 'superadmin').update_all(name: 'Admin')
  end

  def devices
    setup_factory_girl
    User.find_each do |user|
      next if user.devices.any?
      FactoryGirl.create(:device, device_params.merge(user: user))
      FactoryGirl.create(:device, device_params.merge(user: user, sdk_version: 100))
      FactoryGirl.create(:device, device_params.merge(user: user)).destroy
    end
  end

  def publishers
    load_file(:publishers).each do |_, data|
      users     = data.delete('users')
      owner     = User.find_by_email(users.pop)
      publisher = Publisher.find_by(name: data['name'])
      publisher = owner.create_owned_publisher data if publisher.blank?
      users.each do |email|
        user = User.find_by_email(email)
        next unless user
        publisher.publisher_users.create_with(active: true).find_or_create_by!(user: user)
      end
    end
  end

  def categories
    create_category = ->(parent, data) do
      children = data.delete('children')
      category = Category.with_name_translation(data['name_translations']['en'], :en).first
      category ||= Category.create!(data.merge(parent: parent))
      children.try!(:each) { |child_data| create_category.call(category, child_data) }
    end
    load_file(:categories).each { |_, data| create_category.call(nil, data) }
  end

  def apps
    setup_factory_girl
    category_ids = Category.children.pluck(:id)
    publisher = Publisher.where.not(name: 'MyCom').first!
    ApkParser.stubs.each_with_index do |attrs, i|
      next if App.where(package_name: attrs[:package_name]).exists?
      app = nil
      ApkParser.stub(i) do
        app = FactoryGirl.create(:app, :published,
          category_ids: category_ids.sample(1), publisher: publisher)
      end
      ApkParser.stub(attrs.merge version_code: (attrs[:version_code] + 1)) do
        FactoryGirl.create(
          :app_version,
          :published,
          app: app,
          apk: File.open(Rails.root.join 'spec/fixtures/apks/test.apk')
        )
      end
    end
  end

  def inapps
    app = usual_app
    EditorTracking.tap(&:testing!).stub(app.publisher.owner) do
      load_file(:inapps).each do |_, data|
        next if Inapp.unscoped.find_by(sku: data['sku'])
        deleted = data.delete('deleted')
        data.delete('type').constantize.new(data.merge(app: app)).
          tap(&:fix_prices).tap(&:save!).tap { |x| x.destroy if  deleted }
      end
    end
  end

  def downloads
    app = usual_app
    Device.all.each do |device|
      time_freeze 30.days do
        begin
          app.downloads.create app_version: app.versions.sample, device: device
        rescue ActiveRecord::RecordNotUnique
        end
      end
    end
  end

  def run_stats
    app = usual_app
    devices = Device.all
    today = Date.today

    30.times do |day|
      devices.each do |device|
        app.run_stats.create(
          device: device,
          date: today - day,
          launches: rand(1..5),
          duration: rand(1.hour..2.hours)
        )
      end
    end
  end

  def subscriptions
    usual_app.inapps.subscriptions.each do |inapp|
      User.all.each do |user|
        next if InappPurchase.where(user_id: user.id, inapp_id: inapp.id).any?
        time_freeze 30.days do
          inapp.new_purchase(user: user).tap(&:save!).orders.not_paid.first.try! :paid!
        end
      end
    end
  end

  def purchases
    usual_app.inapps.products.each do |inapp|
      User.all.each do |user|
        rand(1..4).times do
          time_freeze 30.days do
            inapp.new_purchase(user: user).tap(&:save!).tap { |x| x.orders.first.paid! }.consumed!
          end
        end
      end
    end
  end

  def app_downloads
    devices = Device.all
    AppVersion.published.joins(:app).where(apps: {status: :published}).each do |version|
      devices.each { |x| AppDownload.track!(version, x) }
    end
  end

  def reviews
    data = load_file(:reviews)
    responses = data['responses']
    responses += [nil] * responses.size # decrease response chance
    AppDownload.find_each do |download|
      next if Review.where(app_id: download.app.id, user_id: download.device.user_id).exists?
      time_freeze 1.month do
        Review.create!(
          user:         download.device.user,
          app:          download.app,
          app_version:  download.app_version,
          title:        data['titles'].sample,
          content:      data['contents'].sample,
          rating:       rand(1..5),
          response:     responses.sample,
        )
      end
    end
  end

  def review_marks
    users = User.all
    marks = ReviewMark::MARKS * 2 - [:abuse] + [:abuse] # decrease abuse chance
    Review.not_rejected.find_each do |review|
      users.each do |user|
        next if user.id == review.user_id || review.marks.exists?(user: user)
        time_freeze(Time.now - [review.created_at, user.created_at].max) do
          review.marks.find_or_create_by!(user: user, mark: marks.sample)
        end
      end
    end
  end

  def app_groups
    data = load_file(:app_groups)
    data.each do |name|
      next if AppGroup.with_name_translation(name, 'en').any?
      app_group = AppGroup.create! name: name
      app_group.apps << usual_apps.sample
    end
  end

  def pages
    load_file(:pages).each do |data|
      next if Page.exists? name: data['name']
      page = Page.create! data.except 'blocks'
      data['blocks'].each do |block_data|
        attrs = block_data
        case block_data['block_type']
        when 'app_group' then attrs.merge! target: AppGroup.all.sample
        when 'category'  then attrs.merge! target: Category.all.sample
        end
        page.blocks.create! attrs
      end
    end
  end

  private

  def load_file(name)
    yaml = Rails.root.join('db', 'seeds', "#{name}.yml")
    YAML.load(ERB.new(IO.read(yaml)).result)
  end

  def open_fixture(*names)
    File.open Rails.root.join('db/seeds', *names)
  end

  def report(name, &block)
    return unless block_given?
    print("Creating #{name}...\t\t")
    block.call
    puts('done')
  end

  def time_freeze(ago, randomize = true)
    Timecop.freeze(Time.now - (randomize ? rand(ago) : ago)) { yield }
  end

  def device_params
    {
      features:     android_constants[:features].sample(rand(10)),
      gl_textures:  android_constants[:gl_textures].sample(rand(3)),
      libraries:    android_constants[:libraries].sample(rand(2)),
      gl_es:        android_constants[:gl_es].sample,
    }
  end

  def android_constants
    @android_constants ||= load_file(:android_constants).symbolize_keys
  end

  def setup_factory_girl
    require 'factory_girl_rails'
    ApkParser.testing!
    require_dependency Rails.root.join 'spec/support/spec_helpers/fixture_file'
    FactoryGirl::SyntaxRunner.class_eval do
      include SpecHelpers::FixtureFile
    end
  end

  def usual_apps
    App.published.where.not package_name: Mystore::PACKAGE_NAME
  end

  def usual_app
    usual_apps.first
  end
end