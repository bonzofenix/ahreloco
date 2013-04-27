class BetaUser < ActiveRecord::Base
  validates :email, uniqueness: true
  attr_accessible :active, :email, :username
  before_save :downcase_username

  def self.can_login?(username)
    q = BetaUser.where('username LIKE ? AND active = ?', "%#{username.downcase}%", true)
    puts "beta sessions: #{q.to_sql}"
    !q.all.empty? 
  end

  def downcase_username
    self.username = username.downcase
  end
end
