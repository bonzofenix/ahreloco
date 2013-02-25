class Program < ActiveRecord::Base
  has_and_belongs_to_many :users
  attr_accessible :name, :avatar_url, :user_ids

end
