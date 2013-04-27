class BetaUser < ActiveRecord::Base
  validates :email, uniqueness: true
  attr_accessible :active, :email, :username
  def self.can_login?(username)
    q = BetaUser.where('username LIKE ? AND active = ?', "%#{username.downcase}%", true)
    puts "beta sessions: #{q.sql}"
    !q.all.empty? 
  end
end
