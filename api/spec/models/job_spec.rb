# == Schema Information
#
# Table name: jobs
#
#  id              :bigint           not null, primary key
#  description     :text
#  employment_type :integer
#  location        :string
#  publish_at      :datetime
#  title           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require 'rails_helper'

RSpec.describe Job, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }

    it { should define_enum_for(:employment_type).with_values(clt: 0, pj: 1, internship: 2) }
  end

  describe 'scopes' do
    describe '.search_by_term' do
      let!(:job1) { create(:job, title: 'Desenvolvedor Ruby', description: 'Especialista Rails para um grande projeto que iniciará em breve', location: 'São Paulo', employment_type: :clt) }
      let!(:job2) { create(:job, title: 'Desenvolvedor Frontend', description: 'Especialista em Vue.js para criar interfaces modernas', location: 'Remoto', employment_type: :pj) }
      let!(:job3) { create(:job, title: 'Engenheiro DevOps', description: 'Especialista em Docker e Kubernetes para infraestrutura em nuvem', location: 'Viamão', employment_type: :clt) }

      it 'finds jobs by title' do
        expect(Job.search_by_term('Ruby')).to include(job1)
        expect(Job.search_by_term('Ruby')).not_to include(job2, job3)
      end

      it 'finds jobs by description' do
        expect(Job.search_by_term('Vue')).to include(job2)
        expect(Job.search_by_term('Vue')).not_to include(job1, job3)
      end

      it 'finds jobs by location' do
        expect(Job.search_by_term('Viamão')).to include(job3)
        expect(Job.search_by_term('Viamão')).not_to include(job1, job2)
      end

      it 'is case insensitive' do
        expect(Job.search_by_term('ruby')).to include(job1)
      end
    end
  end
end
