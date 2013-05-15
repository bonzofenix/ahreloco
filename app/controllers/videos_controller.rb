class VideosController < InheritedResources::Base
  before_filter :authenticate_user!

  def upload
    arl_manager.playlist
    @video = Video.create(params[:video].merge({playlist_id: Playlist.last.id,
      user_id: current_user.id, published_at: Date.today }))
   
    if @video
      @upload_info = arl_manager.client.upload_token(options_for(@video),
       save_video_new_video_url(video_id: @video.id))
    else
      respond_to do |format|
        format.html { render :new }
      end
    end
  end

  def save_video
    @video = Video.find(params[:video_id])
    if params[:status].to_i == 200
      @video.update_attributes(video_id: params[:id].to_s, is_complete: true)
      arl_manager.add_video_to_week_playlist @video 
      #Video.delete_incomplete_videos
    else
      #Video.delete_video(@video)
    end

    redirect_to user_path(current_user), notice: 'video successfully uploaded'
  end

  protected
  def collection
    @videos ||= end_of_association_chain.latest_published.page(params[:page])
  end

  private 
  def options_for(video)
    opts = {title: video.title,
            description: video.description,
            category: 'People',
            keywords: ['test'],
            private: false, 
         #   list: "denied"
          }
  end
end

