
Started GET "/" for 127.0.0.1 at 2018-01-11 14:05:04 +0300
Processing by Face::HomeController#show as HTML
  Rendered engines/face/app/views/face/home/show.html.slim within layouts/application (5.0ms)
  Rendered engines/authentication/app/views/authentication/_menu.html.slim (4.0ms)
  Rendered engines/face/app/views/layouts/face/_application.html.slim (2016.0ms)
Completed 500 Internal Server Error in 2048ms (ActiveRecord: 0.0ms)

ActionView::Template::Error (undefined method `call' for nil:NilClass):
    2: html
    3:   head
    4:     title Octoshell
    5:     = favicon_link_tag 'favicon.ico'
    6:     = favicon_link_tag 'apple-touch-icon-precomposed.png', type: 'image/png'
    7:     = favicon_link_tag 'apple-touch-icon-precomposed.png', rel: 'apple-touch-icon', type: 'image/png'
    8:     link href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css" rel="stylesheet"
  app/views/layouts/application.html.slim:6:in `_app_views_layouts_application_html_slim___302728767_19298'


  Rendered /home/pavel/.rbenv/versions/jruby-9.0.5.0/lib/ruby/gems/shared/gems/actionpack-4.2.10/lib/action_dispatch/middleware/templates/rescues/_source.erb (32.0ms)
  Rendered /home/pavel/.rbenv/versions/jruby-9.0.5.0/lib/ruby/gems/shared/gems/actionpack-4.2.10/lib/action_dispatch/middleware/templates/rescues/_trace.html.erb (10.0ms)
  Rendered /home/pavel/.rbenv/versions/jruby-9.0.5.0/lib/ruby/gems/shared/gems/actionpack-4.2.10/lib/action_dispatch/middleware/templates/rescues/_request_and_response.html.erb (3.0ms)
  Rendered /home/pavel/.rbenv/versions/jruby-9.0.5.0/lib/ruby/gems/shared/gems/actionpack-4.2.10/lib/action_dispatch/middleware/templates/rescues/template_error.html.erb within rescues/layout (102.0ms)