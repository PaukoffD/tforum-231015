require 'rails_helper'


describe Topic do
 it 'is valid subject and..' do
    expect(build(:forum)).to be_valid
 end
 
 it 'is invalid without subject' do
    forum=build(:forum, subject: nil)
    expect(forum.errors[:subject]).to include "cant be blank"
 end
 
end