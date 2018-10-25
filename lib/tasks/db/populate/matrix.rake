namespace :db do
  namespace :populate do
    desc 'Erase and fill matrixs table'
    task matrix: :environment do

      Matrix.delete_all

      3.times do
        Matrix.create!(name: Faker::DragonBall.character)
      end
    end
  end
end
