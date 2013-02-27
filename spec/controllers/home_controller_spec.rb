require 'spec_helper'

describe HomeController do
  [:program_with_channels, :other_program_with_channels].each do |name|
    let(name) do
      create(:program).tap do |p|
        2.times do
          p.users.each do |u| 
            u.videos.create(attributes_for(:video))
            u.videos.create(attributes_for(:older_video))
          end
        end
      end
    end
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end

    it 'returns the latest video of each program' do
      program_with_channels
      other_program_with_channels
      get 'index'
      assigns(:lattest_program_videos).should == [
        program_with_channels.lattest_video,
        other_program_with_channels.lattest_video]
    end
  end
end
