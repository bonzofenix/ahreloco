# read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :program do
    name 'alans programs'
    avatar_url 'www.my-avatar-url.com'

    trait :with_channel do
      users{ |v| [v.association(:user)] }
    end

    trait :with_channels_and_videos do
      users do |v| 
        [].tap do |a|
          a << v.association(:user, :with_videos)
          a << v.association(:user, :with_videos)
        end
      end 
    end
  end
end
