require 'spec_helper'

describe HomeController do
  include_context 'youtube it mocks'
  let(:user){ create(:user) }

  describe 'when signed in' do
    describe '.index' do
      before{ sign_in user}
      it 'returns http success' do
        get :index
        response.should be_success
      end
      
      describe 'top videos' do
        before do
          create :playlist, :with_video 
          create :playlist, :with_video 
          create :video
          get :index
        end
        
        it 'assings videos' do
          assigns(:videos).should_not be_nil
        end

        it 'assings top today' do
          assigns(:week_conquest).should_not be_nil
        end

        it 'assings top today, week and month for comunity' do
          assigns(:top_today).should_not be_nil
          assigns(:top_week).should_not be_nil
          assigns(:top_month).should_not be_nil
        end

        it 'assings top today, week and month for programs' do
          assigns(:top_today_programs).should_not be_nil
          assigns(:top_week_programs).should_not be_nil
          assigns(:top_month_programs).should_not be_nil
        end
      end
    end
  end
end
