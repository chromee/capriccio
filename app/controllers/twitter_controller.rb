class TwitterController < ApplicationController
  include Common

  def timeline
    client = client_new
    @user = client.user
    @tweets = client.mentions
  end

  def reply
    # client.update("@mn_chorome test", in_reply_to_status_id: )
  end

  def tweet
    capture = Capture.find(params[:cpature_id].to_i)
    client = client_new
    open(capture.picture.path) do |img|
      @response = client.update_with_media(params[:tweet_body], img)
    end
  end

end
