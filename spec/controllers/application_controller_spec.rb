require 'spec_helper' 

describe ApplicationController do
  it 'returns a youtube client' do
    controller.client.should be_kind_of(YouTubeIt::Client)
  end

  it 'returns the arl_manager' do
    controller.arl_manager.should be_kind_of(ArlManager)
  end

  describe '.user_or_arl_client' do
    it 'uses the the login client' do
      sign_in create(:user)
      ApplicationController.any_instance.should_receive :client
      controller.user_or_arl_client
    end
    
    it 'uses the default client' do
      ArlManager.any_instance.should_receive :client
      controller.user_or_arl_client
    end
  end
end
