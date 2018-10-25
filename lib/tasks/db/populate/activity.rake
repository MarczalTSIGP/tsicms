namespace :db do
  namespace :populate do
    desc 'Erase and fill activities table'
    task activity: :environment do

      Activity.delete_all

      10.times do
        Activity.create!(
          name: Faker::Job.unique.title,
          description: Faker::Lorem.paragraph(2)
        )
      end
    end
  end
end
