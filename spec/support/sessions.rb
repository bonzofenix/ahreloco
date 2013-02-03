module Sessions
  def sign_in(user)
    ApplicationController.any_instance.stub(current_user: user)
  end
end
