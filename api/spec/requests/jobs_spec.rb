require 'rails_helper'

RSpec.describe 'Jobs', type: :request do
  describe 'GET /jobs' do
    it 'returns published jobs that are scheduled for now or earlier, including ones without a publish date' do
      visible_job = create(:job, publish_at: 1.day.ago)
      scheduled_job = create(:job, publish_at: 1.day.from_now)
      no_date_job = create(:job, publish_at: nil)
      create(:job, publish_at: 2.days.ago)

      get '/jobs'

      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body)
      job_ids = body.fetch('jobs').map { |job| job.fetch('id') }

      expect(job_ids).to include(visible_job.id, no_date_job.id)
      expect(job_ids).not_to include(scheduled_job.id)
    end
  end
end
