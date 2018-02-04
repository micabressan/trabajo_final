class StackModuleWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  D_MODULES_ARRAY = %w(
    4cc1faeca0435e17774d1673
    50058c38592f4d393dea87f5
    50058e3a74535d393dea87f5
    4cc1faec98641e17774d1673
    4cc1faeca325de17774d1673
)  # d_module: slider, promo_banners, character_slider, recommended, stream

  def perform
    connect_to_weisshorn = -> { ActiveRecord::Base.establish_connection  ActiveRecord::Base.configurations['development']['external']  }
    connect_to_domain = -> { ActiveRecord::Base.establish_connection  ActiveRecord::Base.configurations['development']['domain'] }
    new_pos = ->(arg, arr) do
      if 0 == arg
        arr.unshift arg
      elsif !arr.include?(arg)
        if arr.include?(arg-1)
          new_ind = arr.find_index(arg-1) +1
          arr.insert(new_ind ,arg)
        end
      else
        return
      end
    end

    portal = Mongoid::Clients.default[:portals].find({slug: 'video'}).first
    @mongo_stack_module_pages = Array.new

    # @todo: don't remove this array, we need all pages
    %i(homepages video_pages game_pages  section_pages).each do |table|
      @mongo_stack_module_pages += Mongoid::Clients.default[table].find({portal_id: portal['_id'] }).select(&:present?)
    end

    %i( movie_pages character_pages )
        .each { |t| @mongo_stack_module_pages += Mongoid::Clients.default[t].find.select(&:present?) }
    @mongo_stack_module_pages.each do |page|
      InnerLogger.set_connection_domain
      InnerLogger.create_page_or_update(
        bson_id: page['_id'],
        entity: page,
        klass: 'Page'
      )
      begin
        @stack_module_positions = page['module_positions']
      rescue ActiveRecord::Exception
        @stack_module_positions = nil
      end

      if @stack_module_positions

        @desktop, @tablet, @mobile = @stack_module_positions.values_at *%w(desktop tablet mobile)

        @default_positions = page['stack_modules'].pluck(:default_position)

        if @default_positions
          @stack_modules_visibility = {desktop: [], mobile: [], tablet: []}
          %i(desktop mobile tablet).each do |visible|
            @default_positions.each do |dp|
              instance_variable_get("@#{visible}").public_send(:include?, dp) ?
                @stack_modules_visibility[visible].push(true) :
                @stack_modules_visibility[visible].push(false)
            end
          end
        end
        [@desktop, @tablet, @mobile].each do |iter|
          @default_positions.each do |pos|
            iter.include?(pos) ? next : new_pos[pos, iter]
          end
        end
      end
      if @stack_module_positions && @stack_modules_visibility

        stack_modules, page_id = page.values_at 'stack_modules', '_id'
        connect_to_domain.call
        pg_page_id = InnerLogger.find_by(mongo_id: page_id.to_s, klass: 'Page').try(:pg_id) || nil
        connect_to_weisshorn.call
        StackModule.where(page_id: pg_page_id).each do |mdl|
          mdl.title&.delete
          ManualSelection.where(stack_module_id: mdl.id).delete_all
          mdl.delete
        end unless pg_page_id.nil?

        stack_modules.sort { |a, b| a['default_position'] <=> b['default_position'] }.each do |stack_module|
          next if stack_module['drill_id'].present?
          connect_to_domain.call
          d_module = InnerLogger.find_by(mongo_id: stack_module['d_module'].to_s, klass: 'DModule')
          d_module_id = d_module.pg_id
          connect_to_weisshorn.call

          new_stack_module = StackModule.new(
            stack_module_value: {},
            module_position: %i(desktop mobile tablet).reduce({}) do |hsh, plat|
              hsh.merge "#{plat}".intern => instance_variable_get("@#{plat}").send(:index, stack_module['default_position'])
            end,
            available: %i(desktop mobile tablet).reduce({}) do |hsh, plat|
              hsh.merge "#{plat}".intern => @stack_modules_visibility[plat][stack_module['default_position']]
            end,
            d_module_id: d_module_id,
            page_id: pg_page_id
          )

          # this will set attributes for slider


          new_stack_module.build_title(title: stack_module['title']) if stack_module['title'].presence

          if new_stack_module.save
            StackModule.find(new_stack_module.id).update_attribute(
              :stack_module_value,
               get_value(d_module, stack_module, new_stack_module.id)
            )
            # creating autofills
            auto_fill = AutofillSelection.new(stack_module_id: new_stack_module.id)
            case stack_module['chosenBy']
              when 'all'
                #%w(autofill_limit sorting_attrs).each do |attr|
                  #if stack_module[attr].presence then auto_fill.field_all[attr] = stack_module[attr] end
                #end
                # @todo: sorting_attrs
                auto_fill.field_all['limit'] = stack_module['autofill_limit'] # !important: without present
                if stack_module['autofill_portal_id'].presence
                  connect_to_domain.call
                  autofill_portal_id = InnerLogger.find_by(mongo_id: stack_module['autofill_portal_id'], klass: 'Portal').pg_id
                  connect_to_weisshorn.call
                  auto_fill.field_all['portal_id'] = autofill_portal_id.to_i
                end
                auto_fill.sql_field_all!
              when 'nothing'
                auto_fill.sql_nothing!
              when 'query'
                #%w(autofill_limit sorting_attrs queryJson).each do |attr|
                  #if stack_module[attr].presence then auto_fill.field_all[attr] = stack_module[attr] end
                #end
                # @todo: sorting_attrs
                auto_fill.field_query['limit'] = stack_module['autofill_limit'] # !important: without present
                if stack_module['queryJson'].presence
                  begin
                    json = JSON.parse stack_module['queryJson']
                    if json[0].present?
                      auto_fill.field_query['query'] = []
                      json[0]['ands'].each do |cond|
                        #stack_module['field']['ands'].each do ||
                        query_obj = {}
                        query_obj['clause'] = cond['condition'].try(:upcase) || 'IS'
                        query_obj['object_type'] = {}
                        query_obj['object_type'][%(Objects::#{cond['field']})] = cond['field']
                        # @todo: hmmm... angular??
                        query_obj['object_type']['key'] = %(Objects::#{cond['field']})
                        query_obj['object_type']['value'] = cond['field']

                        query_obj['object_ids'] = []
                        cond['value'].split(',').each do |val_id|
                          connect_to_domain.call
                          obj_id = InnerLogger.find_by(mongo_id: val_id, klass: %(Objects::#{cond['field']})).pg_id
                          connect_to_weisshorn.call
                          klass_const = InnerLogger.send :_klass_to_const, %(Objects::#{cond['field']})
                          # @todo: VERY unstable 8(
                          query_obj['object_ids'] << {id: obj_id, title: klass_const.find(obj_id).title.title}
                        end
                        auto_fill.field_query['query'] << query_obj
                      end
                    end
                  rescue
                  end
                end
                if stack_module['autofill_portal_id'].presence
                  connect_to_domain.call
                  autofill_portal_id = InnerLogger.find_by(mongo_id: stack_module['autofill_portal_id'], klass: 'Portal').pg_id
                  connect_to_weisshorn.call
                  auto_fill.field_query['portal_id'] = autofill_portal_id
                end
                auto_fill.sql_field_query!
              when 'current'
                auto_fill.sql_field_current!
              when 'related'
                auto_fill.sql_field_related!
              else
                auto_fill.sql_nothing!
            end
            auto_fill.save



            if %w(4f8ce379522275313d473c15 50058bd5c79f2d393dea87f5).include? stack_module['d_module']  # d_module HeroUniversal and entity_hero _id property
              new_stack_module.update(objectable_type: 'HeroObject') # hardcoded HeroObject for HeroUniversal's objectable_type
              stack_module['content'].each_with_index  do |hero_obj, position|
                hero_obj = hero_obj.sub('HeroObject:', '').split(':').first
                connect_to_domain.call
                if InnerLogger.where(mongo_id: hero_obj).first.nil?
                  InnerLogger.create_hero_object_or_update(
                    bson_id: hero_obj,
                    entity: Mongoid::Clients.default[:hero_objects].find({_id: BSON::ObjectId(hero_obj)}).first,
                    klass: 'HeroObject'
                  )
                  connect_to_domain.call
                end
                objectable_id = InnerLogger.where(mongo_id: hero_obj).first.pg_id
                connect_to_weisshorn.call
                objectable = HeroObject.find objectable_id
                ManualSelection.create(position: position, stack_module_id: new_stack_module.id, objectable: objectable)
              end

            elsif stack_module['d_module'].in? D_MODULES_ARRAY
              if 'ExternalLink' == stack_module['content_type']
                klass = stack_module['content_type']
              elsif stack_module['content_type'].end_with? 'Page'
                type = stack_module['content_type'].underscore.split('_').each(&:capitalize!).first
                klass = %(Objects::#{type})
              end


              new_stack_module.update(objectable_type: klass)
              # manuals_count = 0
              stack_module['content'].each_with_index do |cont, ind|
                content_id = cont.sub("#{stack_module['content_type']}:", '').split(':').first
                connect_to_domain.call
                objectable_id = InnerLogger.where(mongo_id: content_id , klass: klass)
                                  .try(:first).try(:pg_id)
                next if objectable_id.nil?
                connect_to_weisshorn.call
                objectable = klass.constantize.find objectable_id
                ManualSelection.create(position: ind + 1, stack_module_id: new_stack_module.id, objectable: objectable)
                # manuals_count += 1 : next
              end
            elsif '4f8ce56d4320a5313d473c15' == stack_module['d_module'] # featured_media

              next

              # elsif '50058e3a74535d393dea87f5' == stack_module['d_module'] # promo_banners DModule

              # elsif '5121bd5d233e7cb05ce75c00' == stack_module['d_module'] #stitch
            end
          else
            pp new_stack_module.errors
          end
        end
      end
    end
  end

  private
    def get_value(d_module, stack_module, pg_id)
      ActiveRecord::Base.establish_connection ActiveRecord::Base.configurations['development']['domain']

      case d_module.mongo_id
      when '4cc1faeca0435e17774d1673' # slider
        stack_module_value = {
          title_header: stack_module['title_header'].presence,
          title_link: stack_module['title_link'].presence,
          background_color: stack_module['background_color'].presence,
          background_gradient: stack_module['background_gradient'].presence,
          promo_availability: _promo_value(stack_module),
          heading_color: (stack_module['heading_color'].present? ?
            ('#2e2e2e' != stack_module['heading_color'] ? stack_module['heading_color'] : '') :
            '#014176'),
          show_main_connection: stack_module['display_main_connection'].present? && true == stack_module['display_main_connection'],
          assets: {
            asset: {
              background_image: InnerAsset.make_asset(entity: stack_module, klass: 'StackModule', pg: pg_id, field: 'background_image')
            }
          }
        }
      when '4cc1faec98641e17774d1673' # recommended
        stack_module_value = {
          title_link: stack_module['title'],
          show_main_connection: stack_module['display_main_connection'].present? && true == stack_module['display_main_connection'],
          assets: {
            asset: {
              background_image: InnerAsset.make_asset(entity: stack_module, klass: 'StackModule', pg: pg_id, field: 'background_image')
            }
          }
        }
      when '4cc1faeca325de17774d1673' # stream
        stack_module_value = {
          promo_availability: _promo_value(stack_module),
        }
      when '4cc1faeca9bdee17774d1673' # watch
        stack_module_value = {
          show_main_connection: stack_module['display_main_connection'].present? && true == stack_module['display_main_connection']
        }
        when '50058eba9acc1d393dea87f5' # video gallery

        stack_module_value = {
            title_link: stack_module['title_link'].presence,
            title_header: stack_module['title_header'].presence,
            object_description_text_color: stack_module['object_description_text_color'].presence,
            object_header_text_color: stack_module['object_header_text_color'].presence,
            heading_color: (stack_module['heading_color'].present? ?
                                ('#2e2e2e' != stack_module['heading_color'] ? stack_module['heading_color'] : '') :
                                '#014176'),
            background_color: stack_module['background_color'].presence,
            background_gradient: stack_module['background_gradient'].presence,
            link_color: stack_module['link_color'].presence,
            assets: {
                asset: {
                    background_image: InnerAsset.make_asset(entity: stack_module, klass: 'StackModule', pg: pg_id, field: 'background_image')
                }
            }
        }

      when '50058cb1c19a9d393dea87f5' #image gallery
        stack_module_value = {
            title_header: stack_module['title_header'].presence,
            title_link: stack_module['title_link'].presence,
            heading_color: (stack_module['heading_color'].present? ?
                                ('#2e2e2e' != stack_module['heading_color'] ? stack_module['heading_color'] : '') :
                                '#014176'),
            background_color: stack_module['background_color'].presence,
            background_gradient: stack_module['background_gradient'].presence,
            assets: {
                asset: {
                    background_image: InnerAsset.make_asset(entity: stack_module, klass: 'StackModule', pg: pg_id, field: 'background_image')
                }
            }
        }

        when '4e4da0ffc9fed5b59aa6f6e2' # about
        stack_module_value = {
            title_header: stack_module['title_header'].presence,
            title_link: stack_module['title_link'].presence,
            text_color: stack_module['text_color'],
            heading_color: (stack_module['heading_color'].present? ?
                                ('#2e2e2e' != stack_module['heading_color'] ? stack_module['heading_color'] : '') :
                                '#014176')
        }
        else
        stack_module_value = {}
      end
      ActiveRecord::Base.establish_connection ActiveRecord::Base.configurations['development']['external']

      stack_module_value.each_key { |k| stack_module_value.delete(k) if stack_module_value[k].nil? }.itself
    end

    def _promo_value stack_module
      return 'without' if !stack_module['promo_availability'].present? || 'Without Promo' == stack_module['promo_availability']
      return 'all' if 'All' == stack_module['promo_availability']
      'promo'
    end
end