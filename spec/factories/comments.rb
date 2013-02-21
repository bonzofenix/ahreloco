# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    video_id "MyString"
    comment_id "MyString"
    content "MyString"
    reply_to "MyString"
    user
  end
end
