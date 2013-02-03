class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :user_signed_in?

  def yt_client
    token = session[:yt_token]
    @yt_client ||= YouTubeIt::OAuth2Client.new(client_access_token: token,
      client_refresh_token: token, 
      client_id: ENV['YOUTUBE_KEY'], client_secret: ENV['YOUTUBE_SECRET'],
      dev_key: ENV['DEV_KEY'], expires_at: Time.now + 50.minutes)
  end
  
  def arl_manager
ArlManager.new
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def user_signed_in?
    !current_user.nil?
  end
end
