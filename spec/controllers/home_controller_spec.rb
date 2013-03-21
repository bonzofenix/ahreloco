require 'spec_helper'

describe HomeController do
  include_context 'youtube it mocks'
  
  describe '.index' do
    it 'returns http success' do
      get :index
      response.should be_success
    end
    
    describe 'top videos' do
      before do
        create :video
        get :index
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
