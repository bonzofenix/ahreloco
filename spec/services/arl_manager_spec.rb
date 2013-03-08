require 'spec_helper'

describe ArlManager do
  let(:user){ create :user }
  let(:video){ create :video }
  let(:manager){ ArlManager.new }
  include_context 'youtube it mocks'

  it 'returns a youtube client' do
    manager.client.should be_kind_of(YouTubeIt::Client)
  end

  describe 'when listing the week conquest videos' do
    it 'should return a list of videos' do
      manager.week_videos.should be_kind_of(Array)
    end
  end
  
  describe 'when adding a video to the week playlist' do
    before do
      manager.client.should_receive(:add_video_to_playlist)
    end

    it 'creates the playlist if it doesnt exist' do
      pending
      manager.client.stub(playlists: [])
      manager.client.should_receive(:add_playlist).and_return(playlists.first)
      manager.add_video_to_week_playlist(video)
    end
   
    it 'doesnt create the playlist if exists' do
      pending
      manager.client.should_not_receive(:add_playlist)
      manager.add_video_to_week_playlist(video)
    end

    it 'adds a video to the week playlist' do
      manager.add_video_to_week_playlist(video)
    end
  end
  
end
