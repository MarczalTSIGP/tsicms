namespace :db do
  namespace :populate do
    desc 'Erase and fill activitiy_professors table'
    task activitiy_professor: :environment do

      ActivityProfessor.delete_all

      10.times do
        ActivityProfessor.create!(
          professor: Professor.all.sample,
          activity: Activity.all.sample,
          start_date: Faker::Date.between(1.year.ago, 5.months.ago),
          end_date: [nil, Faker::Date.between(5.months.ago, Date.today)].sample
        )
      end
    end
  end
end
