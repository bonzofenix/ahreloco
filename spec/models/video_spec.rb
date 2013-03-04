require 'spec_helper'

describe Video do
  let(:video){ create :video } 

  describe 'when serializing images' do
    it 'sets thbnails serialized' do
      video.thumbnails = [{url: 'asd', height: 90, width:10}] 
      video.serialized_thumbnails.should == "---\n- :url: asd\n  :height: 90\n  :width: 10\n" 
    end

    it 'returns them unserialized' do
      video.serialized_thumbnails = "---\n- :url: asd\n  :height: 90\n  :width: 10\n" 
      video.thumbnails.should == [{url: 'asd', height: 90, width:10}]
    end
  end
  
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
end
