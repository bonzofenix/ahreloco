class Comment < ActiveRecord::Base
  belongs_to :user
  attr_accessible :comment_id, :content, :reply_to, :video_id, :user_attributes
end
