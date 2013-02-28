class VideosController < InheritedResources::Base
  def upload
    @video = Video.create(params[:video])
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
    @videos ||= end_of_association_chain.order('published_at DESC').page(params[:page])
  end

  private 
  def options_for(video)
    opts = {title: video.title,
            description: '',
            category: 'People',
            keywords: ['test'],
            private: 'true' }
  end

end

