FactoryGirl.define do
  factory :group do
    sequence(:name) { |i| "group name #{i}" }
    description 'new group description'
    trait :enabled do
      enabled true
    end
  end
end
