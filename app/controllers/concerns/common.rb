module Common
  extend ActiveSupport::Concern

  def client_new
    Twitter::REST::Client.new do |config|
      config.consumer_key = ENV.fetch('TWITTER_API_KEY')
      config.consumer_secret = ENV.fetch('TWITTER_API_SECRET')
      config.access_token = session[:oauth_token]
      config.access_token_secret = session[:oauth_token_secret]
    end
  end

end
