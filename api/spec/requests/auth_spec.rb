require 'rails_helper'

RSpec.describe 'Auth', type: :request do
  let(:default_headers) { { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' } }
  describe 'POST /auth/login' do
    let(:user) { create(:user) }

    context 'with valid credentials' do
      it 'returns success and Authorization header' do
        post '/auth/login', params: { user: { email: user.email, password: user.password } }.to_json, headers: default_headers

        expect(response).to have_http_status(:ok)
        expect(response.headers['Authorization']).to be_present
        json = JSON.parse(response.body)
        expect(json['data']['user']['email']).to eq(user.email)
      end
    end

    context 'with invalid credentials' do
      it 'returns unauthorized' do
        post '/auth/login', params: { user: { email: user.email, password: 'wrongpassword' } }.to_json, headers: default_headers

        expect(response).to have_http_status(:unauthorized)
        expect(response.headers['Authorization']).to be_nil
      end
    end
  end

  describe 'DELETE /auth/logout' do
    let(:user) { create(:user) }

    it 'returns success' do
      delete '/auth/logout'

      expect(response).to have_http_status(:no_content)
    end
  end

  describe 'GET /auth/me' do
    let(:user) { create(:user) }

    context 'when authenticated' do
      it 'returns current user info' do
        # Login to get token
        post '/auth/login', params: { user: { email: user.email, password: user.password } }.to_json, headers: default_headers
        token = response.headers['Authorization']

        get '/auth/me', headers: { 'Authorization' => token }

        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json['data']['user']['id']).to eq(user.id)
        expect(json['data']['user']['email']).to eq(user.email)
      end
    end

    context 'when not authenticated' do
      it 'returns unauthorized' do
        get '/auth/me'

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
