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

    pending 'refreshing token' do
      describe 'when its too old' do
        before do
          session[:token_created_at] = 51.minutes.ago
        end
      
        it 'it refreshes the token if its 51 minutes old' do
          YouTubeIt::Client.any_instance.should_receive :refresh_access_token!
          controller.user_or_arl_client
        end

        it 'updates the yt_token' do
          expect do
            controller.user_or_arl_client
          end.to change{ session[:yt_token] }
        end

        it 'updates the token_created_at' do
          expect do
            controller.user_or_arl_client
          end.to change{ session[:token_created_at] }
        end
      end

      describe 'when its not that old' do
        before do
          session[:token_created_at] = 49.minutes.ago
        end

        it 'it dont refresh the token if its 49 minutes old' do
          YouTubeIt::Client.any_instance.should_not_receive :refresh_access_token!
          controller.user_or_arl_client
        end
      end
    end
  end
end
