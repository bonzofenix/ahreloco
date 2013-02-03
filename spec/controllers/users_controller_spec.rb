require 'spec_helper'

describe UsersController do
  let(:user){ create :user, :with_video }

  describe 'GET index' do
    it "returns http success" do
      get 'index'
      response.should be_success
    end

  end
  
  describe 'get show' do
    before do
      controller.should_receive(:check_for_new_videos)
    end

    it "returns http success" do
      get 'show', id: user.id
      response.should be_success
    end

    it "returns all the users videos" do
      get 'show', id: user.id
      assigns(:videos).should_not be_nil
    end

    it 'sets the default video' do
      get 'show', id: user.id
      assigns(:default_video).should == user.videos.last
    end

    it 'accepts params for default video' do
     
      get 'show', id: user.id
      assigns(:default_video).should == user.videos.last
      
    end
  end
end
