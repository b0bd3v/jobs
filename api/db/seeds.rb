User.find_or_create_by!(email: 'admin@example.com') do |user|
  user.password = 'password'
  user.password_confirmation = 'password'
end

puts '-> Criado usuário admin'

Job.destroy_all
puts '-> Vagas antigas removidas.'

jobs_file = File.read(Rails.root.join('db', 'jobs.json'))
jobs_data = JSON.parse(jobs_file)

jobs_data.each do |job|
  Job.create!(
    title: job['title'],
    description: job['description'],
    location: job['location'],
    employment_type: job['employment_type'],
    publish_at: (DateTime.parse(job['publish_at']) if job['publish_at'].present?)
  )
end

puts "-> #{Job.count} vagas adicionadas"
