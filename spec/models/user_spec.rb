require 'spec_helper'

describe User do
  let(:user){ create :user }
  include_context 'youtube it mocks'

  describe '.add_videos' do
    it 'adds videos' do
      expect do
        user.add_videos([youtube_it_video])
      end.to change{Video.count}
    end

    it 'adds the thumbnails' do
      user.add_videos([youtube_it_video])
      Video.last.thumbnails.length.should == video_thumbnails.length 
    end
  end
end
