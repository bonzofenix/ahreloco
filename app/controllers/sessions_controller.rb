class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    @user = User.find_for_youtube(auth)
    @user.update_youtube_attributes(auth)
    session[:user_id] = @user.id
    session[:username] = @user.username
    session[:yt_token] = auth['credentials']['token']
    redirect_to user_path(@user), :notice => "Signed in!"
  end
  
  def failure
    flash[:error]= 'Error al iniciar sesion: esto puede deberse a que la cuenta de gmail no tenga ninguna cuenta de youtube asociada'  
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end
end
