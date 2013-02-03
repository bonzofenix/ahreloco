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
end
