require 'spec_helper'

describe CommentsController do
  include_context 'youtube it mocks'
  let(:video_id){ '2rIwQs7C1T4'}
  let(:comment){ build :comment }

  before do
    YouTubeIt::Client.any_instance.stub(:comments).with(video_id).and_return([youtube_it_comment])
  end

  it 'gets comments for the video' do
    xhr :get, :index, video_id: video_id     
    response.should be_ok
  end

  
  it 'gets the comments' do
    xhr :get, :index, video_id: video_id
    assigns(:comments).should be_kind_of(Array)
  end

  it 'creates a new comment' do
    YouTubeIt::Client.any_instance.should_receive(:add_comment).with(comment.video_id, comment.content)
    xhr :post, :create, comment: attributes_for(:comment)
  end
end
