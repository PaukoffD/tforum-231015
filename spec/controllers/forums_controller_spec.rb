require 'rails_helper'
require 'spec_helper'

RSpec.configure { |c| c.before { expect(controller).not_to be_nil } }

RSpec.describe ForumsController do
  describe 'GET index' do
    it 'has a 200 status code' do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe 'GET #index' do
    it 'display all visible forums' do
      forum = FactoryGirl.create(:forum)
      get :index
      expect(:forums).to eq([forum])
    end
  end

  describe 'GET new' do
    it 'has a 200 status code' do
      get :new
      expect(response.status).to eq(200)
    end
  end

  describe 'GET #new' do
    it 'creates a new forum ' do
      get :new
      expect(assigns(:forum)).to be_a_new(Forum)
    end
  end
end
