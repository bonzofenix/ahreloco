class BetaUser < ActiveRecord::Base
  attr_accessible :active, :email, :username
  def self.can_login?(username)
    !BetaUser.where(username: "%#{username}%", active: true).all.empty?   
  end
end
