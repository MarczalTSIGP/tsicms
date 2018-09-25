namespace :db do

  desc "Erase and fill database"
  task :populate => :environment do

    [Faq].each(&:delete_all)

    10.times do
      Faq.create!(
          title: Faker::Name.name,
          answer: Faker::Markdown.random
      )
    end
  end
end