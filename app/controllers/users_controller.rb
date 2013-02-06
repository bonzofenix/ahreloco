class UsersController < InheritedResources::Base
  actions :show

  def show
    @user = User.find(params[:id])
    arl_manager.check_new_videos_for(@user)
    @videos = @user.videos
    @default_video = @videos.last unless params[:video_id]
    @default_video ||= @user.videos.find(params[:video_id])
  end
end
