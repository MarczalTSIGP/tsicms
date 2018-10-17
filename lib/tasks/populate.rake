namespace :db do
  desc 'Erase and Fill database'
  task populate: :environment do
    [CategoryRecommendation, Recommendation, Professor, ProfessorCategory,
     ProfessorTitle, Academic].each(&:destroy_all)

    categories = %w(Documentário Filme Livro Seriado)
    categories.each do |category|
      CategoryRecommendation.create!(name: category)
    end

    CategoryRecommendation.all.each do |category|
      5.times do
        category.recommendations.create! title: Faker::Name.name,
          description: Faker::Lorem.paragraph(2),
          image: File.open(Dir["#{Rails.root}/spec/samples/images/*"].sample)
      end
    end

    categories = %w[Efetivo Temporário]
    categories.each do |category|
      ProfessorCategory.create!(name: category)
    end

    titles = [
      {name: 'Especialista', abbrev: 'Esp.'},
      {name: 'Mestre', abbrev: 'Me.'},
      {name: 'Doutor', abbrev: 'Dr.'}
    ]

    titles.each do |title|
      ProfessorTitle.create!(name: title[:name], abbrev: title[:abbrev])
    end

    10.times do
      Professor.create!(name: Faker::Name.name, lattes: Faker::Internet.url,
                        occupation_area: Faker::Job.title, email: Faker::Internet.email,
                        professor_title: ProfessorTitle.all.sample,
                        professor_category: ProfessorCategory.all.sample)
    end

    6.times do
      Academic.create!(
        name: Faker::Name.name,
        image: File.open(Dir["#{Rails.root}/spec/samples/images/*"].sample),
        contact: Faker::Internet.url,
        graduated: [true, false].sample
      )
    end

    3.times do
      DisciplineMonitor.create!(semester: Faker::Number.between(1, 2),
                        year: Faker::Number.between(2015, 2018),
                        description: Faker::Lorem.characters(10),
                        academic: Academic.all.sample,
                        monitor_type: MonitorType.all.sample
      )
    end
  end
end
