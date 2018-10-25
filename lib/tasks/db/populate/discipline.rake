namespace :db do
  namespace :populate do
    desc 'Erase and fill disciplines table'
    task discipline: :environment do

      Discipline.delete_all

      Period.all.each do |period|
        7.times do
          Discipline.create!(
            name: Faker::Company.unique.industry,
            code: Faker::Code.nric(27, 34),
            hours: Faker::Number.number(2),
            period: period,
            menu: Faker::Markdown.random
          )
        end
      end
    end
  end
end
