require 'rails_helper'

describe Group do
  it { should have_and_belong_to_many(:users) }
  it { should have_and_belong_to_many(:categories) }
  it { should validate_presence_of(:name) }

  pending 'after approve must belong to creator'
end
