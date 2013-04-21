class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :user_signed_in?

  def user_or_arl_client
    current_client = current_user.nil? ? arl_manager.client : client
    #if session[:token_created_at] < 50.minutes.ago
      #current_client.refresh_access_token!
    #end

    current_client
  end

  def authenticate_user!
    redirect_to root_path, notice: 'Debe estar logeado para aceder!' unless user_signed_in?
  end

  def client
    token = session[:yt_token]
    @client ||= YouTubeIt::AuthSubClient.new(token: token, dev_key: ENV['DEV_KEY'])
  end
  
  def arl_manager
    ArlManager.new
  end

  def is_beta?
    ENV['BETA'] == 'true'
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def user_signed_in?
    !current_user.nil?
  end
end
