require 'spec_helper'

describe User do
  let(:user){ create :user }
  let(:video_categories) do
    [YouTubeIt::Model::Category.new( term: 'Music',label:'Music')]
  end
  
  let(:video_format) do
#    YouTubeIt::Model::Video::Format.new(format_code:0, name: :flash)
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
  let(:video) do
    YouTubeIt::Model::Video.new(
      video_id: 'tag:youtube.com,2008:video:pw4F_0TWmE8',
      published_at: '2007-10-10 01:23:33 UTC',
      updated_at: '2009-06-01 00:17:40 UTC',
      uploaded_at: '2007-10-10 01:23:33 UTC',
      recorded_at: nil,
      categories: video_categories, 
      keywords: ["moran", "mayumoran"], 
      title: "mayumoran impro moran",
      html_content: nil,
      author: user,
      description: "asdasdasd", 
      duration: 43, 
      media_content: video_media_content,
      player_url: "http://www.youtube.com/watch?v=pw4F_0TWmE8&feature=youtube_gdata_player",
      thumbnails: video_thumbnails, 
      rating: nil, 
      view_count: 64,
      favorite_count: 0, 
      comment_count: 0,  
      state: {:name=>"published"},
      unique_id: "pw4F_0TWmE8")
  #access_control: {"comment"=>"allowed", "commentVote"=>"allowed", "videoRespond"=>"allowed", "rate"=>"allowed", "embed"=>"allowed", "list"=>"allowed", "autoPlay"=>"allowed", "syndicate"=>"allowed"}, widescreen=nil, noembed=false, safe_search=false, position=nil, latitude=nil, longitude=nil, insight_uri="http://insight.youtube.com/video-analytics/csvreports?query=pw4F_0TWmE8&type=v&starttime=1235865600000&endtime=1358812800000&user_starttime=1358208000000&user_endtime=1358812800000&region=world&token=5fPxnkTu-DUAj85JeK3aOAxoY_Z8MTM1ODkwOTU0OEAxMzU4OTA3NzQ4&hl=en_US&devKey=AQfZjMxrOmtc1cLP4a6EgXwO88HsQjpE1a8d1GxQnGDm", perm_private=false>
  end

  describe '.add_videos' do
    it 'adds videos' do
      expect do
        user.add_videos([video])
      end.to change{Video.count}
    end

    it 'adds the thumbnails' do
      user.add_videos([video])
      Video.last.thumbnails.length.should == video_thumbnails.length 
    end
  end
end