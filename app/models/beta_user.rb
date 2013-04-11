class BetaUser < ActiveRecord::Base
  validates :email, uniqueness: true
  attr_accessible :active, :email, :username
  def self.can_login?(username)
    !BetaUser.where('username LIKE ? AND active = ?', "%#{username.downcase}%", true).all.empty?   
  end
end
