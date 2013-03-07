require 'spec_helper'

describe HomeController do

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
        assigns(:top_taday).should_not be_nil
      end

      it 'assings top today' do
        assigns(:week_conquest).should_not be_nil
      end

      it 'assings top week' do
        assigns(:top_week).should_not be_nil
      end

      it 'assings top month' do
        assigns(:top_month).should_not be_nil
      end
    end
  end
end
