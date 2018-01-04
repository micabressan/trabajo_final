require 'eventmachine'
require 'sinatra/base'
require 'thin'
require 'em-hiredis'
require 'json'

def run(opts)

  # Start he reactor
  EM.run do

    # define some defaults for our app
    server  = opts[:server] || 'thin'
    host    = opts[:host]   || '0.0.0.0'
    port    = opts[:port]   || '8181'
    web_app = opts[:app]

    dispatch = Rack::Builder.app do
      map '/' do
        run web_app
      end
    end

    Rack::Server.start({
                           app:    dispatch,
                           server: server,
                           Host:   host,
                           Port:   port,
                           signals: false,
                       })
    $redis = EM::Hiredis.connect
  end
end

class UrlShortener < Sinatra::Base
  configure do
    set :threaded, false
  end

  post '/', :provides => :json do
    #EM.defer do
    p 'start'
      token = SecureRandom.hex(4)
    p "my token: #{token}"
    p "my url: #{params[:longUrl]}"
      $redis.set(token, params[:longUrl]).callback {
        p 'start in redis'
        #content_type :json
        { :url => token}.to_json
        p 'finish in redis'
      }
    #end
  end
end

# start the application
run app: UrlShortener.new