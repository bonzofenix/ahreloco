require 'spec_helper'

describe UsersController do
  let(:user){ create :user, :with_video }
  let(:video){ create :video, user: user }
  let(:other_video){ create :video, user: user }
  include_context 'youtube it mocks'

  describe 'user signed in' do
    before do
      sign_in user
    end


    describe 'when user doesnt have any videos' do
      it 'redirects to a profile page' do
        user.videos.destroy_all
        get 'show', id: user.id
        response.should redirect_to(user_profile_path(user))
      end
    end


    describe 'get show' do
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
      
      describe 'when the user is found' do
        it "returns http success" do
          get 'show', id: user.id
          response.should be_success
        end

        it 'updates the selected video' do
          YouTubeIt::Client.any_instance.stub(videos_by: stub(videos: [youtube_it_video] ))
          Video.any_instance.should_receive(:update_with)
          get 'show', id: user.id
        end

        it 'looks up for the video' do
          video
          expect do
            get 'show', id: user.id, video_id: video.id
          end.to change{ video.reload.updated_at }
        end

        it "returns all the users videos" do
          get 'show', id: user.id
          assigns(:videos).should_not be_nil
        end

        it 'sets the default video' do
          get 'show', id: user.id
          assigns(:video).should == user.videos.reload.last
        end

        it 'checks for new videos' do
          controller.should_receive :check_for_new_videos
          get :show, id: user.id
        end

        it 'hits the video' do
          Video.any_instance.should_receive :hit_it! 
          get :show, id: user.id, video_id: video.id
        end
      end
    end
  end
end
