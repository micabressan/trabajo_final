json.merge! stack_module.attributes
json.extract! stack_module, :title
json.d_module do
  unless stack_module.d_module.nil?
    json.merge! stack_module.d_module.attributes
    json.extract! stack_module.d_module, :code, :title
  end
end
json.autofill_selection do
  json.merge! stack_module.autofill_selection&.attributes
end
json.manual_selections stack_module.manual_selections do |ms|
  json.merge! ms.attributes
  json.objectable do
    json.merge! ms.objectable.attributes
    json.extract! ms.objectable, :title
    if ms.objectable.respond_to? :asset
      json.extract! ms.objectable, :asset
    end
    if 'HeroObject' == ms.objectable_type && !ms.objectable.css_banner_id.nil?
      json.css_banner do
        json.merge! ms.objectable.css_banner.attributes
        json.extract! ms.objectable.css_banner, :asset
      end
    end
    if ms.objectable_type.starts_with?('Objects')
      page = Page.find_by(objectable_id: ms.objectable_id, objectable_type: ms.objectable_type)
      unless page.nil?
        json.page do
          json.merge! page.attributes
          json.extract! page, :asset, :title, :code
        end
      end
    end
  end
end