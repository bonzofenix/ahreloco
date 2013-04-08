class UsersController < InheritedResources::Base
  before_filter :authenticate_user!
  actions :show

  def show
    @user = User.find(params[:id])
    arl_manager.check_new_videos_for(@user)
    @videos = @user.videos
    @default_video = params[:video_id].nil? ? @videos.last : @user.videos.find(params[:video_id])
    @default_video.hit_it!
    @default_video.update_with(arl_manager.get_video(@default_video.video_id))
  rescue ActiveRecord::RecordNotFound
    flash[:notice] = 'Este usuario no pose una cuenta en AhReloco.tv'
    redirect_to home_index_path
  end
end
