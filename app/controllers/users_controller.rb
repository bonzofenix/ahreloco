class UsersController < InheritedResources::Base
  before_filter :authenticate_user!
  actions :show

  def show
    @user = User.find(params[:id])
    check_for_new_videos
    update_video_values
    hit_video
  rescue ActiveRecord::RecordNotFound
    flash[:notice] = 'Este usuario no pose una cuenta en AhReloco.tv'
    redirect_to home_index_path
  end

  def update_video_values
    return unless video
    youtube_video = youtube_videos.select{|v| v.video_id.split(':').last == video.video_id }
    video.update_with(youtube_video.first) unless youtube_video.empty?
  end
  
  def video
    @video ||= params[:video_id].nil? ? @videos.last : @user.videos.find(params[:video_id])
  end

  def hit_video
    video.hit_it! if video
  end

  def check_for_new_videos
    @user.add_videos(youtube_videos)
    @videos = @user.videos
  end
  

  def youtube_videos
    @youtube_videos ||= client.videos_by(user: @user.username).videos
  end
end
