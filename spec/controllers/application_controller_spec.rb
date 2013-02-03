require 'spec_helper' 

describe ApplicationController do
  it 'returns a youtube client' do
    controller.yt_client.should be_kind_of(YouTubeIt::Client)
  end

  it 'returns the arl_manager' do
    controller.arl_manager.should be_kind_of(ArlManager)
  end
end
