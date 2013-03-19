require 'spec_helper'

describe CommentsController do
  include_context 'youtube it mocks'
  let(:video_id){ '2rIwQs7C1T4'}
  let(:comment){ build :comment }

  describe 'user signed in' do
    before{ sign_in create(:user) }

    describe '.index' do
      it 'gets comments for the video' do
        xhr :get, :index, video_id: video_id     
        response.should be_ok
      end
    
      describe 'returns a hash with the needed keys' do
        before { xhr :get, :index, video_id: video_id }

        subject{ assigns(:comments).first }

        it{ should have_key(:username) }
        it{ should have_key(:content) }
        it{ should have_key(:time_ago) }
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
end
