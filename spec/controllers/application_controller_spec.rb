require 'spec_helper' 

describe ApplicationController do
  it 'returns a youtube client' do
    controller.yt_client.should be_kind_of(YouTubeIt::Client)
  end

  it 'returns a youtube client' do
    controller.arl_client.should be_kind_of(YouTubeIt::Client)
  end
end
