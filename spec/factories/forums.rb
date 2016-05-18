FactoryGirl.define do
  factory :forum do
    name        {Faker::Lorem.sentence}
	description {Faker::Lorem.paragraph}
	category_id {Faker::Number.number(4)}
    views_count {Faker::Number.number(4)}
    slug        {Faker::Lorem.sentence}
    hidden      {Faker::Boolean.boolean}
  end
end