class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :user_signed_in?
  before_filter :check_session_expiration

  def authenticate_user!
    redirect_to root_path, notice: 'Debe estar logeado para aceder!' unless user_signed_in?
  end

  def check_session_expiration
    if user_signed_in? and session[:token_created_at] < 51.minutes.ago
      redirect_to signout_path, notice: 'La session expiro. loggeate nuevamente!'
    end
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
