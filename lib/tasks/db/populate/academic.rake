namespace :db do
  namespace :populate do
    desc 'Erase and fill academics table'
    task academic: :environment do

      Academic.delete_all

      6.times do
        Academic.create!(
          name: Faker::Name.unique.name,
          image: File.open(Dir["#{Rails.root}/spec/samples/images/*"].sample),
          contact: Faker::Internet.url,
          graduated: [true, false].sample
        )
      end
    end
  end
end
