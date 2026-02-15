User.find_or_create_by!(email: 'admin@example.com') do |user|
  user.password = 'password'
  user.password_confirmation = 'password'
end

puts '-> Criado usuário admin'

Job.destroy_all
puts '-> Vagas antigas removidas.'

[
  {
    title: 'Desenvolvedor Ruby on Rails Sênior',
    description: 'Estamos em busca de uma pessoa desenvolvedora RoR Sênior com sólida experiência em aplicações escaláveis. Diferencial: conhecimento em arquitetura de microsserviços e mentoria de devs mais juniores.',
    status: :published,
    location: 'Remoto',
    employment_type: :pj
  },
  {
    title: 'Desenvolvedor Frontend Júnior React',
    description: 'Vaga para quem está começando e ama o ecossistema React. Você vai atuar na criação de interfaces modernas, utilizando Tailwind CSS e integrando com APIs REST. Oportunidade de muito aprendizado!',
    status: :published,
    location: 'São Paulo, SP',
    employment_type: :clt
  },
  {
    title: 'Fullstack Node/TypeScript',
    description: 'Buscamos alguém que se sinta confortável tanto no backend quando no frontend. Atuamos com uma stack moderna (Node, TS, Next.js) e focamos muito em qualidade de código e testes automatizados.',
    status: :draft,
    location: 'Belo Horizonte, MG',
    employment_type: :clt
  },
  {
    title: 'Estágio Backend',
    description: 'Se você está cursando TI e quer colocar a mão na massa com Ruby e Bancos de Dados, essa vaga é para você. Oferecemos mentoria e um ambiente propício para seu crescimento profissional.',
    status: :published,
    location: 'Remoto',
    employment_type: :internship
  },
  {
    title: 'Especialista DevOps',
    description: 'Responsável por manter nossa infraestrutura na AWS, gerenciar pipelines de CI/CD e garantir a disponibilidade dos serviços. Experiência com Docker e Kubernetes é fundamental para o dia a dia.',
    status: :published,
    location: 'Curitiba, PR',
    employment_type: :pj
  },
  {
    title: 'Product Manager',
    description: 'Procuramos um PM com foco em métricas e experiência do usuário. Você será a ponte entre o negócio e o time de engenharia, definindo prioridades e garantindo a entrega de valor real aos nossos clientes.',
    status: :draft,
    location: 'Remoto',
    employment_type: :clt
  },
  {
    title: 'UX/UI Pleno',
    description: 'Venha desenhar o futuro da nossa plataforma! Esperamos que você tenha domínio de Figma, entenda de design system e saiba conduzir entrevistas com usuários para validar suas hipóteses.',
    status: :published,
    location: 'Florianópolis, SC',
    employment_type: :pj
  },
  {
    title: 'Cientista de Dados com foco em IA/ML',
    description: 'Trabalhe com grandes volumes de dados para gerar insights e modelos preditivos. Requisitos: Python avançado, SQL e vivência com bibliotecas como Scikit-learn, Pandas ou TensorFlow.',
    status: :published,
    location: 'Porto Alegre, RS',
    employment_type: :clt
  },
  {
    title: 'Engenheiro de QA',
    description: 'Sua missão será garantir a qualidade de nossos produtos. Você irá criar e manter suítes de testes usando RSpec para o backend e Cypress para o frontend, além de atuar no shift-left da qualidade.',
    status: :draft,
    location: 'Rio de Janeiro, RJ',
    employment_type: :clt
  },
  {
    title: 'Desenvolvedor Mobile',
    description: 'Desenvolvimento da nossa app mobile para iOS e Android. Diferencial: experiência com React Native.',
    status: :published,
    location: 'Remoto',
    employment_type: :pj
  }
].each do |job|
  Job.create(
    title: job[:title],
    description: job[:description],
    status: job[:status],
    location: job[:location],
    employment_type: job[:employment_type]
  )
end

puts '-> Vagas adicionadas'
