class UsersController < InheritedResources::Base
  actions :show

  def show
    @user = User.find(params[:id])
    arl_manager.check_new_videos_for(@user)
    @videos = @user.videos
    @default_video = params[:video_id].nil? ? @videos.last : @user.videos.find(params[:video_id])
    @default_video.hit_it!
  end
end
