namespace :db do
  namespace :populate do
    desc 'Erase and fill professor_titles table'
    task professor_title: :environment do

      ProfessorTitle.delete_all

      titles = [
        {name: 'Especialista', abbrev: 'Esp.'},
        {name: 'Mestre', abbrev: 'Me.'},
        {name: 'Doutor', abbrev: 'Dr.'}
      ]

      titles.each do |title|
        ProfessorTitle.create!(name: title[:name], abbrev: title[:abbrev])
      end
    end
  end
end
