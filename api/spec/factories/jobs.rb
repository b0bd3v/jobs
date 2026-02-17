# == Schema Information
#
# Table name: jobs
#
#  id              :bigint           not null, primary key
#  description     :text
#  employment_type :integer
#  location        :string
#  publish_at      :datetime
#  status          :integer
#  title           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
FactoryBot.define do
  factory :job do
    title { Faker::Job.title }
    description { Faker::Lorem.paragraph(sentence_count: 5) }
    employment_type { Job.employment_types.keys.sample }
    location { Faker::Address.city }
    publish_at { Time.current }
  end
end
