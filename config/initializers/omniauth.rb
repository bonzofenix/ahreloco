#  OmniAuth.config.full_host = "http://localhost:8080"
  OmniAuth.config.full_host = 'http://ahreloco.herokuapp.com'

Ahreloco::Application.config.middleware.use OmniAuth::Builder do
  provider :youtube, ENV['YOUTUBE_KEY'], ENV['YOUTUBE_SECRET'],
    {:access_type => 'online', :approval_prompt => ''}
end
