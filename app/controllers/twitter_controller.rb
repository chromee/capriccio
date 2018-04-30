class TwitterController < ApplicationController
  include Common

  def timeline
    client = client_new
    @tweets = client.home_timeline(count: 10)
    @capture_id = params[:capture_id].to_i
  end

  def replys
    client = client_new
    @replys = client.mentions(count: 5)
    @tweets_from_replys = client.statuses(@replys.map(&:in_reply_to_status_id))
    @tweets_from_replys = @tweets_from_replys.each_with_object({}) {|tweet, h| h[tweet.id] = tweet }
    @capture_id = params[:capture_id].to_i
  end

  def reply
    capture = Capture.find(params[:capture_id].to_i)
    client = client_new
    open(capture.picture.path) do |img|
      @response = client.update_with_media(params[:tweet_body], img, in_reply_to_status_id: params[:tweet_id].to_i)
    end
    render "twitter/tweet"
  end

  def tweet
    capture = Capture.find(params[:capture_id].to_i)
    client = client_new
    open(capture.picture.path) do |img|
      @response = client.update_with_media(params[:tweet_body], img)
    end
  end

end
