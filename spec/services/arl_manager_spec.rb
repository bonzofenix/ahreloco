require 'spec_helper'

describe ArlManager do
  let(:video){ create :video }
  let(:manager){ ArlManager.new }
  let(:playlists) do
    [].tap do |a|
      a << YouTubeIt::Model::Playlist.new( title: 'concurso semana 5 del 2013',
        playlist_id: '2', published: '2013-01-26T20:32:19.000Z' )
      a << YouTubeIt::Model::Playlist.new( title: 'concurso semana 4 del 2013', 
        playlist_id: '1', published: '2013-02-03T20:32:19.000Z' )
    end
  end

  it 'returns a youtube client' do
    manager.client.should be_kind_of(YouTubeIt::Client)
  end

  describe 'when adding a video to the week playlist' do
    before do
      manager.client.should_receive(:add_video_to_playlist)
    end

    it 'creates the playlist if it doesnt exist' do
      manager.client.stub(playlists: [])
      manager.client.should_receive(:add_playlist).and_return(playlists.first)
      manager.add_video_to_week_playlist(video)
    end
   
    it 'doesnt create the playlist if exists' do
      manager.client.stub(playlists: playlists)
      manager.client.should_not_receive(:add_playlist)
      manager.add_video_to_week_playlist(video)
    end

    it 'adds a video to the week playlist' do
      manager.client.stub(playlists: playlists)
      manager.add_video_to_week_playlist(video)
    end
  end
end
