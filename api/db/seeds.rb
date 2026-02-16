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
    status: job['status'],
    location: job['location'],
    employment_type: job['employment_type']
  )
end

puts "-> #{Job.count} vagas adicionadas"
