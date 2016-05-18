FactoryGirl.define do
  factory :topic do
    user_id     {Faker::Number.number(4)}
    forum_id    {Faker::Number.number(4)}
	subject     {Faker::Lorem.sentence}
	pinned      {Faker::Boolean.boolean}
	locked      {Faker::Boolean.boolean}
	hidden      {Faker::Boolean.boolean}
	views_count {Faker::Number.number(4)}
    slug        {Faker::Lorem.sentence}
    state       {'pending_review'}
	last_id     {Faker::Number.number(4)}
	last_post_at {Faker::Date.backward(14)}
  end
end

