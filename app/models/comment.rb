class Comment < ActiveRecord::Base
  belongs_to :user
  attr_accessible  :comment_id, :content, :reply_to, :updated, :video_id,
    :username
end
