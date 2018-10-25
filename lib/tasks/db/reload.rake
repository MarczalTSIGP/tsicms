namespace :db do
  desc 'Drop, create, migrate, seed and populate database'
  task reload: :environment do
    %w[drop create migrate seed populate].each do |task|
      Rake::Task["db:#{task}"].execute
    end
  end
end
