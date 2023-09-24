require 'rails_helper'

RSpec.describe AuthenticationController, type: :controller do
  let(:user) { create(:user, password: 'password123') }

  describe "POST #register" do
    context "with valid attributes" do
      let(:valid_attributes) {
        {
          name: 'Test Name',
          email: 'test_name@example.com',
          password: 'password123'
        }
      }

      it "creates a new user and returns a token" do
        post :register, params: valid_attributes
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)).to have_key('token')
      end
    end

    context "with invalid attributes" do
      let(:invalid_attributes) {
        {
          name: 'Test',
          email: '',
          password: 'password123'
        }
      }

      it "returns an error" do
        post :register, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to have_key('error')
      end
    end
  end

  describe "POST #login" do
    context "with valid credentials" do
      let(:valid_credentials) {
        {
          email: user.email,
          password: 'password123'
        }
      }

      it "returns a token" do
        post :login, params: valid_credentials
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to have_key('token')
      end
    end

    context "with invalid credentials" do
      let(:invalid_credentials) {
        {
          email: user.email,
          password: 'wrongpassword'
        }
      }

      it "returns an error" do
        post :login, params: invalid_credentials
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)).to have_key('error')
      end
    end
  end
end
