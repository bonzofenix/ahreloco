require 'spec_helper'
 
describe Program do
  let(:program){ create :program }

  describe '.create' do
    it 'creates the program' do
      program.should be_kind_of(Program)
    end
  end
  
  it 'has and belong to many channels' do  
    program.users.first.should be_kind_of(User)
  end
  
  it 'returns latest video' do  
    program.users.first.videos.create(attributes_for(:older_video))
    lattest = program.users.first.videos.create(attributes_for(:video))
    program.lattest_video.should == lattest 
  end
end
