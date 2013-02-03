require 'spec_helper'

describe VideosController do
  let(:user){ create :user }
  let(:video){ create :video } 
  let(:save_video_params) do
    { video_id: video.id, status: 200, id: '2rIwQs7C1T4' }
  end
  render_views

  describe 'when user is logged in' do
    before do
      sign_in(user)
    end

    it 'renders new' do
      get :new
      response.should be_ok
    end
    
    describe 'when uploading a video' do
      it 'creates the video' do
        expect do
          post :upload, video: attributes_for(:video)
        end.to change{ Video.count }
      end
      
      it 'looks for the upload token' do
        YouTubeIt::Client.any_instance.should_receive(:upload_token).and_return({url:'', token:''})
        post :upload, video: attributes_for(:video)
      end
    end

    describe 'when saving video' do
      it 'updates the the yt id' do
        expect do
          get :save_video, save_video_params
        end.to change{ video.reload.yt_id }
      end

      it 'sets as completed' do
        expect do
          get :save_video, save_video_params
        end.to change{ video.reload.is_complete }
      end

      it 'adds videos to week conquests' do
        controller.arl_manager.should_receive :add_video_to_week_playlist
        get :save_video, save_video_params
      end

      it 'redirects to current_user path' do
        get :save_video, save_video_params
        response.should redirect_to(user_path(user.id))
      end

    end
  end

end
