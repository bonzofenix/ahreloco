# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :playlist do
    title 'semana asd'
    youtube_id '123'

    trait :with_video do
      videos{|v| [v.association(:video)] }
    end
  end
end
