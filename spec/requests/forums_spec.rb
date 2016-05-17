require 'rails_helper'

RSpec.describe 'Forums', type: :request do
  describe 'GET /forums' do
    it 'works! (now write some real specs)' do
      get forums_path
      expect(response).to have_http_status(200)
      expect(page).to have_content('Sample App')
    end
  end
end
