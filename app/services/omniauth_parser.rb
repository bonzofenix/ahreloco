module OmniauthParser 
  def self.parse(auth)
    Hashie::Mash.new.tap do |p|
      p.provider = auth['provider']
      p.uid = auth['uid']
      p.avatar_url= auth['info']['image']
      p.subscribers_count = auth['info']['subscribers_count']
      p.username = auth.extra.user_hash.send('yt$username').send('$t')
      p.subscribers_count = auth['info']['subscribers_count']
      p.token = auth['credentials']['token']
    end
  end
end
