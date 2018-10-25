namespace :db do
  namespace :populate do
    desc 'Erase and fill professors table'
    task professor: :environment do

      Professor.delete_all

      10.times do
        Professor.create!(name: Faker::Name.name, lattes: Faker::Internet.url,
                          image: File.open(Dir["#{Rails.root}/spec/samples/images/*"].sample),
                          occupation_area: Faker::Job.title, email: Faker::Internet.email,
                          gender: Professor.genders.values.sample,
                          professor_title: ProfessorTitle.all.sample,
                          professor_category: ProfessorCategory.all.sample)
      end
    end
  end
end
