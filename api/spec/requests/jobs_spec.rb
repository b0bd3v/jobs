require 'rails_helper'

RSpec.describe 'Jobs', type: :request do
  describe 'GET /jobs' do
    before { Job.delete_all }

    it 'returns published jobs that are scheduled for now or earlier, including ones without a publish date' do
      visible_job = create(:job, publish_at: 1.day.ago)
      scheduled_job = create(:job, publish_at: 1.day.from_now)
      no_date_job = create(:job, publish_at: nil)
      create(:job, publish_at: 2.days.ago)

      get '/jobs'

      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body)
      job_ids = body.fetch('jobs').map { |job| job.fetch('id') }

      expect(job_ids).to include(visible_job.id)
      expect(job_ids).not_to include(scheduled_job.id, no_date_job.id)
    end
  end

  describe 'GET /jobs/:id' do
    let(:job) { create(:job) }

    context 'when job exists' do
      it 'returns the job' do
        get "/jobs/#{job.id}"

        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json['id']).to eq(job.id)
        expect(json['title']).to eq(job.title)
      end
    end

    context 'when job does not exist' do
      it 'returns not found' do
        get '/jobs/0'

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
