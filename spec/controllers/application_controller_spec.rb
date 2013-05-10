require 'spec_helper' 

describe ApplicationController do
  let(:user){ create :user }

  it 'returns a youtube client' do
    controller.client.should be_kind_of(YouTubeIt::Client)
  end

  it 'returns the arl_manager' do
    controller.arl_manager.should be_kind_of(ArlManager)
  end

  describe '.check_session_expiration' do
    describe 'when its too old' do
      before do
        sign_in user
        session[:token_created_at] = 51.minutes.ago
      end
    
      it 'it logout the user after 51 minutes' do
        controller.should_receive(:redirect_to)
          .with(signout_path, notice: 'La session expiro. loggeate nuevamente!')
        controller.check_session_expiration
      end
  
    end

    describe 'when its not that old' do
      before do
        session[:token_created_at] = 49.minutes.ago
      end

      it 'it logout the user after 51 minutes' do
        controller.should_not_receive(:redirect_to)

        controller.check_session_expiration
      end
    end
  end
end
