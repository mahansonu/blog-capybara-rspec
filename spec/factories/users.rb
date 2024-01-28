FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "First#{n} Last#{n}" }
    sequence(:email) { |n| "users#{n}@example.com" }
    password {'changeme'}
    password_confirmation { password }
  end
end
