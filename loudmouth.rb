require 'sinatra/base'
require 'sinatra/contrib'
require 'redis'

class LoudMouthApp < Sinatra::Base
  register Sinatra::Contrib

  list = []

  configure do
    redis_url = ENV["REDISTOGO_URL"] || "redis://localhost:6379"
    uri = URI.parse(redis_url)
    set :redis, Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
  end

  get '/' do
    puts "connection made"
    stream do |out|
      settings.redis.subscribe 'time' do |on|
        on.message do |channel, message|
          out << "#{message}\n"
        end
      end
    end
  end

end
