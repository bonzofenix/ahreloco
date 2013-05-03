# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :video_id do |n|
    "youtubeid#{n}"
  end

  factory :video do
    title 'this is the title'
    video_id 

    factory :older_video do
      published_at Date.today - 1.day
    end

    factory :other_video do
      video_id 'w4F_0TWmE8'
    end

    trait :with_user do
      user
    end
  end
end
