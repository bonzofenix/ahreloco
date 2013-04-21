module OmniauthParser 
  def self.parse(auth)
    Hashie::Mash.new.tap do |p|
      p.provider = auth['provider']
      p.uid = auth['uid']
      p.avatar_url= auth['info']['image']
      p.token = auth['credentials']['token']
      p.subscribers_count = auth['info']['subscribers_count']
      p.username = auth.extra.user_hash.send('yt$username').send('$t')
    end
  end
end
