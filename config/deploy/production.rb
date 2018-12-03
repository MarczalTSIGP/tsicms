set :stage, :production

server '206.189.199.196', roles: %w(app web db), primary: true, user: 'deployer'
set :rails_env, "production"
