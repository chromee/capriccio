class TwitterController < ApplicationController

  def timeline
    client = client_new
    @user = client.user
    @tweets = client.home_timeline(include_entities: true)
  end

  private

  def client_new
    Twitter::REST::Client.new do |config|
      config.consumer_key = 'API key'
      config.consumer_secret = 'API secret'
      config.access_token = session[:oauth_token]
      config.access_token_secret = session[:oauth_token_secret]
    end
  end

end
