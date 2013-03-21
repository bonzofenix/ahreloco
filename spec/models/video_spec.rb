require 'spec_helper'

describe Video do
  let(:program){ create :program, :with_channel }
  let(:video){ create :video } 
  let(:other_video_with_program){ create :video, user: program.users.first } 
  include_context 'youtube it mocks'

  describe '.top_today'  do
    it 'responds to method' do
      Video.should respond_to(:top_today)
    end
  end

  describe '.top_week'  do
    it 'responds to method' do
      Video.should respond_to(:top_today)
    end
  end

  describe '.parsed_attributes' do
    subject{ Video.parsed_attributes(youtube_it_video) }

    it 'pars3s published_at' do
      subject[:published_at].should == "2007-10-10 01:23:33 UTC" 
    end

    it 'pars3s published_at' do
      subject[:playlist_id].should == nil
    end

    it 'parses view_count' do
      subject[:view_count].should ==  64
    end

    it 'parses video_id' do
      subject[:video_id].should == "pw4F_0TWmE8" 
    end

    it 'parses title' do
      subject[:title].should == "mayumoran impro moran"
    end

    it 'parses likes' do
      subject[:likes].should == nil
    end

    it 'parses dislikes' do
      subject[:dislikes].should ==  nil
    end

    it 'parses rater_count' do
      subject[:rater_count].should ==  nil
    end
  end

  describe 'hit_it!' do
    it 'hits the views of the day' do
      video
      expect{ video.hit_it! }.to change{ video.reload.arl_views_today }.by 1
    end

    it 'hits the views of the day' do
      video
      expect{ video.hit_it! }.to change{ video.reload.arl_views_week }.by 1
    end

    it 'hits the views of the week' do
      video
      expect{ video.hit_it! }.to change{ video.reload.arl_views_month }.by 1
    end
  end

  it 'returns aonly the videos with programs' do
    video
    other_video_with_program 
    Video.with_program.all.count.should == 1
  end
end
