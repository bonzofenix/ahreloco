shared_context 'youtube it mocks' do

  let(:youtube_it_comment) do
    YouTubeIt::Model::Comment.new( author: youtube_it_author, updated: Date.today )
  end

  let(:youtube_it_author) do
    YouTubeIt::Model::Author.new(name: 'alan moran',
      uri: 'http://www.youtube.com/user/bonzofenix',
      thumbnail_url: 'https://lh3.googleusercontent.com/-z2w28o9Tl34/AAAAAAAAAAI/AAAAAAAAAAA/uzFJ5Ce58oY/s48-c-k/photo.jpg')
  end

  let(:youtube_it_category) do
    YouTubeIt::Model::Category.new( term: 'Music',label:'Music')
  end
  
  let(:video_format) do
#    YouTubeIt::Model::Video::Format.new(format_code:0, name: :flash)
  end

  let(:youtube_it_rating) do
    YouTubeIt::Model::Rating.new(average: 0, max: 10, min: 0, rater_count: 4,
      likes:1, dislikes: 3)
  end

  let(:video_media_content) do
    [].tap do |a|
      a << YouTubeIt::Model::Content.new(url: "http://www.youtube.com/v/pw4F_0TWmE8?version=3&f=user_uploads&c=youtube_it&d=AQfZjMxrOmtc1cLP4a6EgXwO88HsQjpE1a8d1GxQnGDm&app=youtube_gdata",
      format: video_format , duration: 43, mime_type:"application/x-shockwave-flash", default: true)
      a << YouTubeIt::Model::Content.new( url:"rtsp://v8.cache2.c.youtube.com/ClcLENy73wIaTglPmNZE_wUOpxMYDSANFEIKeW91dHViZV9pdEgGUgx1c2VyX3VwbG9hZHNyIQEH2YzMazprXNXCz-GuhIF8DvPB7EI6RNWvHdRsUJxg5gw:/0/0/0/video.3gp", format: video_format, duration:43, mime_type:"video/3gpp", default:false)
      a << YouTubeIt::Model::Content.new( url:"rtsp://v8.cache2.c.youtube.com/ClcLENy73wIaTglPmNZE_wUOpxMYESARFEIKeW91dHViZV9pdEgGUgx1c2VyX3VwbG9hZHNyIQEH2YzMazprXNXCz-GuhIF8DvPB7EI6RNWvHdRsUJxg5gw=/0/0/0/video.3gp", format: video_format, duration:43, mime_type:"video/3gpp", default: false)
    end
  end



  let(:video_thumbnails) do 
    [].tap do |a|
      a << YouTubeIt::Model::Thumbnail.new(url:"http://i.ytimg.com/vi/pw4F_0TWmE8/default.jpg", height: 90, width:120, time:"00:00:21.500", name:nil)
      a << YouTubeIt::Model::Thumbnail.new(url:"http://i.ytimg.com/vi/pw4F_0TWmE8/mqdefault.jpg", height:180, width:320, time:nil, name:nil)
      a << YouTubeIt::Model::Thumbnail.new(url:"http://i.ytimg.com/vi/pw4F_0TWmE8/hqdefault.jpg", height:360, width:480, time:nil, name:nil)
      a << YouTubeIt::Model::Thumbnail.new(url:"http://i.ytimg.com/vi/pw4F_0TWmE8/1.jpg", height:90, width:120, time:"00:00:10.750", name:nil)
      a << YouTubeIt::Model::Thumbnail.new(url:"http://i.ytimg.com/vi/pw4F_0TWmE8/2.jpg", height:90, width:120, time:"00:00:21.500", name:nil)
      a << YouTubeIt::Model::Thumbnail.new(url:"http://i.ytimg.com/vi/pw4F_0TWmE8/3.jpg", height:90, width:120, time:"00:00:32.250", name:nil)
    end
  end

  let(:youtube_it_playlist) do
    YouTubeIt::Model::Playlist.new( title: ArlManager.new.playlist_name,
      playlist_id: 'asd2', published: '2013-01-26T20:32:19.000Z' )
  end

  let(:youtube_it_playlists) do
    [].tap do |a|
      a << youtube_it_playlist
      a << YouTubeIt::Model::Playlist.new( title: 'concurso semana 4 del 2013', 
        playlist_id: 'asd1', published: '2013-02-03T20:32:19.000Z' )
    end
  end

  let(:youtube_it_video) do
    YouTubeIt::Model::Video.new(
      video_id: 'tag:youtube.com,2008:video:pw4F_0TWmE8',
      published_at: '2007-10-10 01:23:33 UTC',
      updated_at: '2009-06-01 00:17:40 UTC',
      uploaded_at: '2007-10-10 01:23:33 UTC',
      recorded_at: nil,
      categories: [youtube_it_category], 
      keywords: ["moran", "mayumoran"], 
      title: "mayumoran impro moran",
      html_content: nil,
      author: youtube_it_author,
      description: "asdasdasd", 
      duration: 43, 
      media_content: video_media_content,
      player_url: "http://www.youtube.com/watch?v=pw4F_0TWmE8&feature=youtube_gdata_player",
      thumbnails: video_thumbnails, 
      rating: youtube_it_rating, 
      view_count: 64,
      favorite_count: 0, 
      comment_count: 0,  
      state: {:name=>"published"},
      unique_id: "pw4F_0TWmE8")
  #access_control: {"comment"=>"allowed", "commentVote"=>"allowed", "videoRespond"=>"allowed", "rate"=>"allowed", "embed"=>"allowed", "list"=>"allowed", "autoPlay"=>"allowed", "syndicate"=>"allowed"}, widescreen=nil, noembed=false, safe_search=false, position=nil, latitude=nil, longitude=nil, insight_uri="http://insight.youtube.com/video-analytics/csvreports?query=pw4F_0TWmE8&type=v&starttime=1235865600000&endtime=1358812800000&user_starttime=1358208000000&user_endtime=1358812800000&region=world&token=5fPxnkTu-DUAj85JeK3aOAxoY_Z8MTM1ODkwOTU0OEAxMzU4OTA3NzQ4&hl=en_US&devKey=AQfZjMxrOmtc1cLP4a6EgXwO88HsQjpE1a8d1GxQnGDm", perm_private=false>
  end

  before do
    YouTubeIt::Client.any_instance.tap do |cli|
      cli.stub(:add_comment)
      cli.stub(:upload_token)
      cli.stub(:add_video_to_playlist)
      cli.stub(:add_playlist).and_return(youtube_it_playlist)
      cli.stub(:comments).and_return( [youtube_it_comment] )
      cli.stub(:playlists).and_return( youtube_it_playlists )
      cli.stub( playlist: stub( videos: [youtube_it_video] ))
      cli.stub( video_by: youtube_it_video )
    end
    YouTubeIt::Model::Playlist.any_instance.tap do |ply|
      ply.stub(:playlist_id)
    end
  end
end


