FactoryBot.define do
  factory :tag do
    sequence(:name) { |n| "Name #{n}"}
    page_tags_count { 1 }
  end
end
