if Rails.env.production? 
  OmniAuth.config.full_host = 'http://ahreloco.tv'
else
  OmniAuth.config.full_host = "http://localhost:8080"
end

OmniAuth.config.on_failure = SessionsController.action(:failure)

Ahreloco::Application.config.middleware.use OmniAuth::Builder do
  provider :youtube, ENV['YOUTUBE_KEY'], ENV['YOUTUBE_SECRET'],
    { approval_prompt: "", access_type: "online"}

end
