namespace :db do
  desc 'Erase and Fill database'
  task populate: :environment do
    [ProfessorCategory, ProfessorTitle, Professor].each(&:destroy_all)

    categories = %w[Efetivo Temporario]

    categories.each do |category|
      ProfessorCategory.create(name: category)
    end

    titles = [
        {description: 'Especialista', abbrev: 'Esp.'},
        {description: 'Mestre', abbrev: 'Me.'},
        {description: 'Doutor', abbrev: 'Dr.'}
    ]

    titles.each do |title|
      ProfessorTitle.create(description: title[:description], abbrev: title[:abbrev])
    end

    10.times do
      Professor.create(name: Faker::Name.name, lattes: Faker::Job.education_level,
                       occupation_area: Faker::Job.title, email: Faker::Internet.email,
                       professor_title: ProfessorTitle.all.sample, professor_category: ProfessorCategory.all.sample)
    end
  end
end