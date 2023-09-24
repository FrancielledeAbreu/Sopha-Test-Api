require 'rails_helper'

RSpec.describe StoresController, type: :controller do
  let(:user) { create(:user) }
  let(:other_user) { create(:user, email: 'other_user@example.com') }
  let(:store) { create(:store, user: user) }
  let(:other_store) { create(:store, user: other_user) }
  let(:token) { JWT.encode({ user_id: user.id }, 'your_secret', 'HS256') }

  before do
    request.headers['Authorization'] = "Bearer #{token}"
  end

  describe 'GET #index' do
    context 'when user is logged in' do
      it "returns the user's stores" do
        get :index
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when user is not logged in' do
      before { request.headers['Authorization'] = nil }

      it 'returns unauthorized' do
        get :index
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'GET #show' do
    context 'when the store exists and belongs to the user' do
      it 'returns the store details' do
        get :show, params: { id: store.id }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when store does not belong to the user' do
      it 'returns not found' do
        get :show, params: { id: other_store.id }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new store and returns its details' do
        post :create, params: { store: attributes_for(:store) }
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid attributes' do
      it 'returns an error' do
        post :create, params: { store: attributes_for(:store, name: nil) }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH/PUT #update' do
    context 'with valid attributes' do
      it 'updates the store and returns its details' do
        put :update, params: { id: store.id, store: { name: 'New Name' } }
        expect(response).to have_http_status(:ok)
        expect(store.reload.name).to eq('New Name')
      end
    end

    context 'with invalid attributes' do
      it 'returns an error' do
        put :update, params: { id: store.id, store: { name: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when store does not belong to the user' do
      it 'returns not found' do
        put :update, params: { id: other_store.id, store: { name: 'New Name' } }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when the store belongs to the user' do
      it 'deletes the store' do
        delete :destroy, params: { id: store.id }
        expect(response).to have_http_status(:ok)
        expect(Store.find_by(id: store.id)).to be_nil
      end
    end

    context 'when store does not belong to the user' do
      it 'returns not found' do
        delete :destroy, params: { id: other_store.id }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
