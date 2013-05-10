require 'spec_helper'

describe SessionsController do
  describe 'when not beta' do
    before do 
      controller.stub(is_beta?: false)
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:youtube] 
    end

    it 'session token_created_at should not come as nil' do
      post :create      
      session[:token_created_at].should_not be_nil
    end

    it 'saves the token in the session' do
        post :create      
        session[:yt_token].should == 'this is the token'
    end

    it 'saves the user id to the session' do
      post :create      
      session[:user_id].should == User.first.id
    end

    it 'redirect to show pat' do
      post :create      
      response.should redirect_to(user_path(User.first))
    end

    it 'creates the user' do
        expect do
          post :create      
        end.to change{User.count}
    end

    it 'creates the user only one time' do
        2.times{ post :create } 
        User.count.should == 1 
    end

    it 'updates the user information on login' do
      User.any_instance.should_receive :update_youtube_attributes
      post :create     
   end

    describe '.failure' do
      it 'flash on failure' do
        get :failure
        flash[:error].should_not be_nil
        response.should redirect_to(root_path)
      end
    end
  end
end
