require 'spec_helper'

describe BetaUsersController do
  describe '.new' do
    it 'response ok' do
      get :new
      response.should be_ok
    end

    it 'response ok' do
      get :new
      assigns(:beta_user).should be_kind_of(BetaUser)
    end
  end

  describe 'create' do
    it 'create the beta user' do
      expect do
        post :create, beta_user: attributes_for(:beta_user)
      end.to change{ BetaUser.count }
    end

    it 'redirects to show' do
      post :create, beta_user: attributes_for(:beta_user)
      response.should redirect_to(user_path(BetaUser.last))
    end
  end
end
