class ArlManager
  attr_accessor :client

  def initialize
    @client = YouTubeIt::Client.new(username:  ENV['ARL_USERNAME'],
      password: ENV['ARL_PASSWORD'], dev_key: ENV['DEV_KEY'])
  end
  
  def playlist_name
    "concurso semana #{Date.today.cweek} del #{Date.today.year}"
  end
  
  def add_video_to_week_playlist(video)
    client.add_video_to_playlist(playlist_id, video.video_id)
  end

  def check_new_videos_for(user)
    videos = @client.videos_by(user: user.username).videos
    user.add_videos(videos)
  end

  def week_videos
    Video.where("playlist_id = '#{playlist_id}'").all.shuffle
  end

  def playlist_id
    playlist.playlist_id
  end
  
  def get_video(id)
    client.video_by(id).videos.first
  end

  def playlist
    return @playlist if @playlist
    @playlist = find_week_playlist || client.add_playlist(title: playlist_name)
  end

  def find_week_playlist
    all_playlists = @client.playlists.select{ |p| p.title == playlist_name }
    @playlist = all_playlists.first if all_playlists
  end
end
