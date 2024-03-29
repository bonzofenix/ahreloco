require 'spec_helper'

describe VideosController do
  include_context 'youtube it mocks'
  let(:user){ create :user }
  let(:video){ create :video } 
  let(:older_video){ create :video, published_at: Date.today - 1.day }
  let(:even_older_video){ create :video, published_at: Date.today - 2.day }

  let(:save_video_params) do
    { video_id: video.id, status: 200, id: '2rIwQs7C1T4' }
  end



  describe 'when user is logged in' do
    before do
      create :playlist
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


      describe 'created video' do
        before do
          post :upload, video: attributes_for(:video) 
        end
  
        subject{ assigns :video }  
        
        its(:published_at){ should_not be_nil }
        its(:playlist_id){ should_not be_nil }
        its(:description){ should_not be_nil }
        its(:user){ should_not be_nil }
      end
      
      it 'looks for the upload token' do
        YouTubeIt::Client.any_instance.should_receive(:upload_token)
          .and_return({url:'', token:''})
        post :upload, video: attributes_for(:video)
      end
    end

    describe 'when saving video' do
      before do 
        ArlManager.any_instance.should_receive :add_video_to_week_playlist
      end

      it 'updates the the video id' do
        expect do
          get :save_video, save_video_params
        end.to change{ video.reload.video_id }
      end


      it 'sets as completed' do
        expect do
          get :save_video, save_video_params
        end.to change{ video.reload.is_complete }
      end

      it 'adds videos to week conquests' do
        get :save_video, save_video_params
      end

      it 'redirects to current_user path' do
        get :save_video, save_video_params
        response.should redirect_to(user_path(user.username))
      end

    end
  end

end
