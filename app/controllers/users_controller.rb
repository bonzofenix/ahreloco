class UsersController < InheritedResources::Base
  def show
    @user = User.find(params[:id])
    check_for_new_videos
    if has_videos?
      update_video_values
      hit_video
    else
      redirect_to user_profile_path(@user)
    end
  rescue ActiveRecord::RecordNotFound
    flash[:notice] = 'Este usuario no pose una cuenta en AhReloco.tv'
    redirect_to home_index_path
  end

  def update_video_values
    return unless video
    debugger
    youtube_video = youtube_videos.select{|v| v.video_id.split(':').last == video.video_id }
    video.update_with(youtube_video.first)
  end
 
  def has_videos?
    @user.has_videos?
  end 

  def video
    @video ||= params[:video_id].nil? ? @user.videos.last : @user.videos.find(params[:video_id])
  end

  def hit_video
    video.hit_it! if video
  end

  def check_for_new_videos
    @user.add_videos(youtube_videos)
    @videos = @user.videos
  end
  

  def youtube_videos
    @youtube_videos ||= arl_manager.client.videos_by(user: @user.username).videos
  end
end
