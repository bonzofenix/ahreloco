require 'spec_helper'

describe ArlManager do
  let(:user){ create :user }
  let(:video){ create :video }
  let(:playlist){ create :playlist }
  let(:manager){ ArlManager.new }
  include_context 'youtube it mocks'

  it 'returns a youtube client' do
    manager.client.should be_kind_of(YouTubeIt::Client)
  end


  describe 'when createing a playlist' do
    it 'creates a playlist' do
      expect do
        manager.create_playlist
      end.to change{ Playlist.count }
    end
  end

  describe 'when adding a video to the week playlist' do
    before do
      manager.client.should_receive(:add_video_to_playlist)
      playlist
    end
    
    it 'adds the video to the week playlist' do
      expect do
        manager.add_video_to_week_playlist(video)
      end.to change{ video.reload.playlist_id }
    end

    it 'creates the playlist if it doesnt exist' do
      manager.client.stub(playlists: [])
      manager.client.should_receive(:add_playlist).and_return( youtube_it_playlist )
      manager.add_video_to_week_playlist(video)
    end
   
    it 'doesnt create the playlist if exists' do
      manager.client.should_not_receive(:add_playlist)
      manager.add_video_to_week_playlist(video)
    end

    it 'adds a video to the week playlist' do
      manager.add_video_to_week_playlist(video)
    end
  end
  
end
