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

  it 'returns latest video' do  
    program.users.first.videos.create(attributes_for(:older_video))
    latest = program.users.first.videos.create(attributes_for(:video))
    program.latest_video.should == latest 
  end
end
