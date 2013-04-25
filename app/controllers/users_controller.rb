class UsersController < InheritedResources::Base
  before_filter :authenticate_user!
  actions :show

  def show
    @user = User.find(params[:id])
    check_for_new_videos
    @video = params[:video_id].nil? ? @videos.last : @user.videos.find(params[:video_id])
    @video.hit_it!
    update_video_values
  rescue ActiveRecord::RecordNotFound
    flash[:notice] = 'Este usuario no pose una cuenta en AhReloco.tv'
    redirect_to home_index_path
  end

  def update_video_values
    youtube_video = youtube_videos.select{ |v| v.video_id.split(':').last == @video.video_id }.first
    @video.update_with(youtube_video) if youtube_video
  end
  
  def check_for_new_videos
    @user.add_videos(youtube_videos)
    @videos = @user.videos
  end
  

  def youtube_videos
    @youtube_videos ||= client.videos_by(user: @user.username).videos
  end
end
