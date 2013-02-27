# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :video do
    title 'this is the title'
    video_id 'pw4F_0TWmE8'
    player_url "MyString"
    published_at Date.today
    factory :older_video do
      published_at Date.today - 1.day
    end
  end
end
