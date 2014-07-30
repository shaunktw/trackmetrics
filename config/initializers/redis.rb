if Rails.env.production?
  uri = URI.parse("redis://redistogo:b65120e03c9a1abdd8e4a543c449510b@hoki.redistogo.com:9292/")
  REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
else
  
  REDIS = Redis.new
end

if Rails.env.production?
  Sidekiq.configure_server do |config|
    config.redis = { :url => ENV["REDISTOGO_URL"], :namespace => "trackmetrics_#{Rails.env}" }
  end

  Sidekiq.configure_client do |config|
    config.redis = { :url => ENV["REDISTOGO_URL"], :namespace => "trackmetrics_#{Rails.env}" }
  end
else
  Sidekiq.configure_server do |config|
    config.redis = { :url => REDIS.client.id, :namespace => "trackmetrics_#{Rails.env}" }
  end

  Sidekiq.configure_client do |config|
    config.redis = { :url => REDIS.client.id, :namespace => "trackmetrics_#{Rails.env}" }
  end
end
