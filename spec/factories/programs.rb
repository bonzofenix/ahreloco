# read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :program do
    name 'alans programs'
    avatar_url 'https://fbcdn-profile-a.akamaihd.net/hprofile-ak-ash3/573637_1247667016_1298245558_q.jpg'
    users{ |v| [v.association(:user)] }
  end
end
