namespace :items do
  desc ''
  task photos: :environment do
    ItemPhoto.where(['item_id NOT IN (?)', Item.pluck(:id)]).destroy_all
    Dir.chdir('/home/shad/projects/mebelorg/public/photos/item_photos/photos')
    local_dirs = `ls -d */`.split
    directories = []
    local_dirs.each do |dir|
      directories << dir.tr('/', '')
    end

    item_photos = ItemPhoto.all.pluck(:id)

    directories_to_remove = directories - item_photos
    directories_to_remove.each do |directory|
      i += 1 if FileUtils.remove_dir(directory)
    end
  end
end