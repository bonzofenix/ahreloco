require 'spec_helper'
 
describe Program do
  let(:program){ create :program, :with_channel }

  [:program_with_channels, :other_program_with_channels].each do |name|
    let(name) { create :program, :with_channels_and_videos }
  end

  describe '.create' do
    it 'creates the program' do
      program.should be_kind_of(Program)
    end
  end
  
  it 'has and belong to many channels' do  
    program.users.first.should be_kind_of(User)
  end
  
  it 'returns the latest video of each program' do
    program_with_channels
    other_program_with_channels
    Program.latest_videos.should == [
      program_with_channels.latest_video,
      other_program_with_channels.latest_video]
  end

  describe '.latest_videos' do
    
    it 'returns the latest video of a program' do  
      latest = nil
      program.users.first.videos.tap do |vs|
        vs.create(attributes_for(:older_video))
        latest = vs.create(attributes_for(:video))
      end

      program.latest_video.should == latest 
    end
  
    it 'sorts videos by latest published' do
      u      
    end
  end
end
