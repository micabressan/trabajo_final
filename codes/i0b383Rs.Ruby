require 'eventmachine'
require 'sinatra/base'
require 'thin'
require 'em-hiredis'

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

  post '/' do
    EM.defer do
      $redis.set('sgsdgs', params[:longUrl]).callback {
        render json: { url: "asafsdf" }
      }
    end
  end
end

# start the application
run app: UrlShortener.new