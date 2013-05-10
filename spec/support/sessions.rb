module Sessions
  def sign_in(user)
    session[:token_created_at] = Time.now
    ApplicationController.any_instance.stub(current_user: user)
  end
end
