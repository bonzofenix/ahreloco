# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    provider "youtube"
    uid "123"
    name "bonzo"
    mail "bonzofenix@gmail.com"

    trait :with_video do
      videos{ |v| [v.association(:video)] }
    end
  end
end
