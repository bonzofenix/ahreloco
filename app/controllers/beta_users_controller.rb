class BetaUsersController < InheritedResources::Base
  skip_before_filter :authenticate_user!, :check_session_expiration
  actions :new, :create, :show
  def create
     create! { beta_user_path(@beta_user) }
  end
end
