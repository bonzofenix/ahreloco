require 'spec_helper'

describe Playlist do
  let(:playlist){ create :playlist }

  it 'returns the video with more views form a playlist' do
    create :video, playlist: playlist, view_count: 1
    winner = create :other_video, playlist: playlist, view_count: 2
    playlist.winner_video.should == winner
  end
  
  it 'returns last week_playlist' do
    last_week = create :playlist
    create :playlist
    Playlist.last_week.should == last_week
  end
end
