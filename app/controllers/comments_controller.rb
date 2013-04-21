class CommentsController < ApplicationController
  include ActionView::Helpers::DateHelper
  def index
    youtube_comments = arl_manager.client.comments(params[:video_id])

    @comments = youtube_comments.collect do |c|
      username = get_username(c.author)      
      comment = Comment.new(username: username,  content: c.content, updated: c.updated) 

      {username: comment.username, content: comment.content,
        time_ago: time_ago_in_words(comment.updated)}
    end

    render text: @comments.to_json 
  end
  
  def create
    @comment = Comment.new(params[:comment])
    arl_manager.client.add_comment(@comment.video_id, @comment.content)
    render nothing: true
  end
  
  private
  def get_username(author)
    author.uri.split('/').last
  end
end
