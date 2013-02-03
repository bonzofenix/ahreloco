# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :video do
    title 'this is the title'
    yt_id "MyString"
    player_url "MyString"
  end
end
