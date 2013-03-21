require 'spec_helper'

describe UsersController do
  let(:user){ create :user, :with_video }
  let(:video){ create :video, user: user }
  let(:other_video){ create :video, user: user }


  describe 'user signed in' do
    before{ sign_in create(:user) }

    describe 'get show' do
      before do
        ArlManager.any_instance.stub(:check_new_videos_for)
      end

      describe 'when user is not found' do
        it 'redirects to home' do
          get 'show', id: 123123
          response.should redirect_to(home_index_path)
        end

        it 'flashes alert' do
          get 'show', id: 123123
          flash[:notice].should_not be_nil
        end
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

      it 'checks for new videos' do
        ArlManager.any_instance.should_receive :check_new_videos_for
        get :show, id: user.id
      end

      it 'hits the video' do
        Video.any_instance.should_receive :hit_it! 
        get :show, id: user.id, video_id: video.id
      end
    end
  end
end
