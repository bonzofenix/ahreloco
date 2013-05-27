# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :playlist do
    title 'semana asd'
    youtube_id '123'

    trait :with_video do
      videos{|v| [v.association(:video)] }
    end

    trait :with_videos do
      videos{|v| [v.association(:video), v.association(:video, view_count: 100)] }
    end
  end
end
