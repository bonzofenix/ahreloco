# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :beta_user do
    username "MyString"
    active false
    email "MyString"
  end
end
