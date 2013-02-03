class VideosController < InheritedResources::Base
  
  def upload
    @video = Video.create(params[:video])
    if @video
      @upload_info = arl_client.upload_token(options_for(@video),
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
      @video.update_attributes(yt_id: params[:id].to_s, is_complete: true)
      #Video.delete_incomplete_videos
    else
      #Video.delete_video(@video)
    end

    redirect_to user_path(current_user), notice: 'video successfully uploaded'
  end

  private 
  def options_for(video)
    opts = {title: video.title,
            description: '',
            category: 'People',
            keywords: ['test']}
     # video.is_unpublished ? opts.merge(private: 'true') : opts
  end
end

