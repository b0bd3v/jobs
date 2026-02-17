require 'rails_helper'

RSpec.describe 'Admin::Jobs', type: :request do
  let(:user) { create(:user) }
  let(:default_headers) { { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' } }
  
  # Helper to get auth token
  def login(user)
    post '/auth/login', params: { user: { email: user.email, password: user.password } }.to_json, headers: default_headers
    response.headers['Authorization']
  end

  describe 'GET /admin/jobs' do
    before { Job.delete_all }

    it 'returns all jobs' do
      create(:job)
      create(:job)
      
      auth_headers = default_headers.merge('Authorization' => login(user))
      get '/admin/jobs', headers: auth_headers

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['data'].size).to eq(2)
      expect(json['total']).to eq(2)
    end
  end

  describe 'POST /admin/jobs' do
    let(:valid_attributes) do
      { 
        job: { 
          title: 'New Job', 
          description: 'This is a very long description that meets the minimum length requirement of 30 characters.', 
          employment_type: 'clt', 
          location: 'Remote', 
          publish_at: Time.current 
        } 
      }
    end

    it 'creates a new job' do
      auth_headers = default_headers.merge('Authorization' => login(user))
      
      expect {
        post '/admin/jobs', params: valid_attributes.to_json, headers: auth_headers
      }.to change(Job, :count).by(1)

      expect(response).to have_http_status(:created)
    end

    it 'returns validation errors for invalid attributes' do
      auth_headers = default_headers.merge('Authorization' => login(user))
      invalid_attributes = { job: { title: '' } }

      expect {
        post '/admin/jobs', params: invalid_attributes.to_json, headers: auth_headers
      }.not_to change(Job, :count)

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'GET /admin/jobs/:id' do
    let(:job) { create(:job) }

    it 'returns the job' do
      auth_headers = default_headers.merge('Authorization' => login(user))
      get "/admin/jobs/#{job.id}", headers: auth_headers

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['id']).to eq(job.id)
    end
  end

  describe 'PUT /admin/jobs/:id' do
    let(:job) { create(:job) }
    let(:new_attributes) { { job: { title: 'Updated Title' } } }

    it 'updates the job' do
      auth_headers = default_headers.merge('Authorization' => login(user))
      put "/admin/jobs/#{job.id}", params: new_attributes.to_json, headers: auth_headers

      expect(response).to have_http_status(:ok)
      expect(job.reload.title).to eq('Updated Title')
    end
  end

  describe 'DELETE /admin/jobs/:id' do
    let!(:job) { create(:job) }

    it 'deletes the job' do
      auth_headers = default_headers.merge('Authorization' => login(user))
      
      expect {
        delete "/admin/jobs/#{job.id}", headers: auth_headers
      }.to change(Job, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end
  end
end
