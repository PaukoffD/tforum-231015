require 'rails_helper'


describe Forum do
 it 'is valid name,description and..' do
    expect(build(:forum)).to be_valid
 end
 
 it 'is invalid without name' do
    forum=build(:forum, name: nil)
    expect(forum.errors[:name]).to include "cant be blank"
 end
 
end