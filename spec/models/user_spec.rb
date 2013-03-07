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

    it 'ignnores a video if published_ar = nil' do
      youtube_it_video.stub(:published_at)
      expect do
        user.add_videos([youtube_it_video])
      end.not_to change{Video.count}
    end

    describe 'parsing video' do
      before{ user.add_videos([youtube_it_video]) }
      subject{ Video.last }

      it 'adds the thumbnails' do
        subject.thumbnails.length.should == video_thumbnails.length 
      end

      it 'adds the likes' do 
        subject.likes.should_not be_nil
      end 

      it 'adds the dislikes' do 
        subject.dislikes.should_not be_nil
      end 

      it 'adds the dislikes' do 
        Video.last.rater_count.should_not be_nil
      end 
    end 
  end
  
  describe 'rating' do  
    before do
      create :video, user: user, likes: 1, dislikes: 2
      create :video, user: user, likes: 3, dislikes: 1
    end

    it 'returns the amounts of likes in a video' do
      user.likes.should == 4
    end

    it 'returns the amounts of dislikes in a video' do
      user.dislikes.should == 3
    end
  end
end
