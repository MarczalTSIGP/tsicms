namespace :db do
  namespace :populate do
    desc 'Erase and fill discipline_monitors table'
    task discipline_monitor: :environment do

      DisciplineMonitor.delete_all

      3.times do
        dm = DisciplineMonitor.create!(semester: DisciplineMonitor.semesters.values.sample,
                                       year: Faker::Number.between(2015, 2018),
                                       description: Faker::Lorem.characters(10),
                                       academic: Academic.all.sample,
                                       monitor_type: MonitorType.all.sample)

        dm.discipline_monitor_professors.create professor: Professor.all.sample
      end
    end
  end
end
