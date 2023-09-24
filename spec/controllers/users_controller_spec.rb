require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }
  let(:token) { JWT.encode({ user_id: user.id }, 'your_secret', 'HS256') }

  before do
    request.headers['Authorization'] = "Bearer #{token}"
  end

  describe 'GET #show' do
    it 'returns user details' do
      get :show
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['id']).to eq(user.id)
    end
  end

  describe 'GET #stores' do
    it "returns user's stores" do
      get :stores
      expect(response).to have_http_status(:ok)
    end
  end
end
