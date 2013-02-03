class UsersController < ApplicationController
  def index
  end

  def show
    check_for_new_videos
    @videos = User.find(params[:id]).videos
    @default_video = @video
  end

  private
  
  def check_for_new_videos
    current_user.add_videos(yt_client.my_videos.videos)
  end
end
