class CommentsController < ApplicationController
  def index
    @comments = user_or_arl_client.comments(params[:video_id])
    parsed_comments = @comments.collect do |c|
      username = c.author.uri.split('/').last
      {username: username,  content: c.content }
    end

    render text: parsed_comments.to_json 
  end
  
  def create
    @comment = Comment.new(params[:comment])
    user_or_arl_client.add_comment(@comment.video_id, @comment.content)
    render nothing: true
  end
end
