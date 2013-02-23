require 'spec_helper'

describe SessionsController do
  before do 
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:youtube] 
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

  it 'overrides the subscriptors count every time he logs in' do
    post :create      
    request.env['omniauth.auth']['info']['subscribers_count'] = '100'
    expect do
      post :create      
    end.to change{User.first.subscribers_count}
  end
end
