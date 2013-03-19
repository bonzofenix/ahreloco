class SessionsController < ApplicationController
  skip_before_filter :authenticate_user!

  def create
    auth = OmniauthParser.parse(request.env["omniauth.auth"])
    if is_beta? and !BetaUser.can_login?(auth.username)
      redirect_to(root_path, notice: 'usted no ha sido invitado aun a formar parte de ahreloco')
    else 
      @user = User.find_for_youtube(auth)
      @user.update_youtube_attributes(auth)
      session[:user_id] = @user.id
      session[:username] = @user.username
      session[:yt_token] = auth.token
      redirect_to user_path(@user), notice: 'Bienvenido'
    end
  end
  
  def failure
    flash[:error]= 'Error al iniciar sesion: esto puede deberse a que la cuenta de gmail no tenga ninguna cuenta de youtube asociada'  
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to home_index_path, notice: 'cerraste sesion'
  end
end
