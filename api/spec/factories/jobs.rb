FactoryBot.define do
  factory :job do
    title { Faker::Job.title }
    description { Faker::Lorem.paragraph(sentence_count: 5) }
    employment_type { Job.employment_types.keys.sample }
    location { Faker::Address.city }
    status { :published }
  end
end
