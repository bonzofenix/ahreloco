require 'spec_helper'

describe CommentsController do
  include_context 'youtube it mocks'
  let(:video_id){ '2rIwQs7C1T4'}
  let(:comment){ build :comment }

  describe '.index' do
    it 'gets comments for the video' do
      xhr :get, :index, video_id: video_id     
      response.should be_ok
    end
  
    it 'it returns a list of comments' do
      xhr :get, :index, video_id: video_id
      assigns(:comments).first.should be_kind_of(Comment)
    end
  end

  describe '.create' do
    it 'creates a new comment' do
      YouTubeIt::Client.any_instance.should_receive(:add_comment)
        .with(comment.video_id, comment.content)
      xhr :post, :create, comment: attributes_for(:comment)
    end
  
    it 'returns a comment' do
      xhr :post, :create, comment: attributes_for(:comment)
      assigns(:comment).should be_kind_of(Comment)
    end
  end
end
