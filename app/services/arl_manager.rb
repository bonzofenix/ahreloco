class ArlManager
  attr_accessor :client

  def initialize
    @client = YouTubeIt::Client.new(username:  ENV['ARL_USERNAME'],
      password: ENV['ARL_PASSWORD'], dev_key: ENV['DEV_KEY'], client_id: ENV['YOUTUBE_KEY'])
  end
  
  def playlist_name
    "concurso semana #{Date.today.cweek} del #{Date.today.year}"
  end
  
  def add_video_to_week_playlist(video)
    client.add_video_to_playlist(playlist_id, video.video_id)
    video.update_attributes(playlist_id: Playlist.last.id)
  end

  def playlist_id
    playlist.playlist_id
  end

  def week_videos
    Playlist.last.videos.all.shuffle if Playlist.last
  end

  def playlist
    return @playlist if @playlist
    find_week_playlist_in_youtube || create_playlist
  end
  
  def create_playlist
    opts = { title: playlist_name }
    client.add_playlist(opts).tap do |p|
      Playlist.create!(opts.merge(youtube_id: p.playlist_id))
    end
  end

  def find_week_playlist_in_youtube
    all_playlists = client.playlists.select{ |p| p.title == playlist_name }
    @playlist = all_playlists.first if all_playlists
  end
end
