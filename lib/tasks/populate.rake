require './spec/support/file_spec_helper'

namespace :db do
  desc 'Erase and Fill database'
  task populate: :environment do
    [CategoryRecommendation,
     Recommendation,
     Activity,
     Professor,
     ProfessorCategory,
     ProfessorTitle,
     DisciplineMonitor,
     Academic,
     Discipline,
     Period,
     Matrix,
     Faq,
     StaticPage,
     Trainee,
     TraineeStatus,
     Picture,
     Gallery].each(&:delete_all)

    Admin.create_with(name: 'Administrador', password: '123456')
         .find_or_create_by!(email: 'admin@admin.com')

    10.times do
      Faq.find_or_create_by!(
        title: Faker::Name.unique.name,
        answer: Faker::Markdown.random
      )
    end

    categories = %w[Documentário Filme Livro Seriado]
    categories.each do |category|
      CategoryRecommendation.find_or_create_by!(name: category)
    end

    CategoryRecommendation.all.each do |category|
      5.times do
        category.recommendations.create!(title: Faker::Name.name,
                                         description: Faker::Lorem.paragraph(2),
                                         image: FileSpecHelper.image)
      end
    end

    categories = %w[Efetivo Temporário]
    categories.each do |category|
      ProfessorCategory.find_or_create_by!(name: category)
    end

    titles = [
      { name: 'Especialista', abbrev: 'Esp.' },
      { name: 'Mestre', abbrev: 'Me.' },
      { name: 'Doutor', abbrev: 'Dr.' }
    ]

    titles.each do |title|
      ProfessorTitle.find_or_create_by!(name: title[:name], abbrev: title[:abbrev])
    end

    monitor_types = %w[Remunerada Gratuita]
    monitor_types.each do |type|
      MonitorType.find_or_create_by!(name: type)
    end

    10.times do
      Professor.create!(name: Faker::Name.name, lattes: Faker::Internet.url,
                        image: FileSpecHelper.image,
                        occupation_area: Faker::Job.title, email: Faker::Internet.email,
                        gender: Professor.genders.values.sample,
                        professor_title: ProfessorTitle.all.sample,
                        professor_category: ProfessorCategory.all.sample)
    end

    6.times do
      Academic.create!(
        name: Faker::Name.unique.name,
        image: FileSpecHelper.image,
        contact: Faker::Internet.url,
        graduated: [true, false].sample
      )
    end

    10.times do
      Activity.find_or_create_by!(
        name: Faker::Job.unique.title,
        description: Faker::Lorem.paragraph(2)
      )
    end

    10.times do
      start_date = Faker::Date.between(1.year.ago, 5.months.ago)
      end_date = Faker::Date.between(5.months.ago, Time.zone.today)
      end_date = [nil, end_date].sample

      ActivityProfessor.find_or_create_by!(
        professor: Professor.all.sample,
        activity: Activity.all.sample,
        start_date: start_date,
        end_date: end_date
      )
    end

    3.times do |m_index|
      matrix = Matrix.create!(name: Faker::DragonBall.unique.character)
      10.times do |p_index|
        period = Period.find_or_create_by!(
          name: "#{Faker::Company.suffix}-#{m_index}#{p_index}",
          matrix: matrix
        )

        10.times do |d_index|
          Discipline.find_or_create_by!(
            name: "#{Faker::Company.industry}-#{m_index}#{p_index}-#{d_index}",
            code: Faker::Code.nric(27, 34),
            hours: Faker::Number.number(2),
            period: period,
            menu: Faker::Markdown.random
          )
        end
      end
    end

    10.times do
      StaticPage.find_or_create_by!(
        title: Faker::Name.name,
        sub_title: Faker::Name.name,
        permalink: Faker::Name.unique.name.parameterize,
        content: Faker::Markdown.sandwich
      )
    end

    3.times do
      DisciplineMonitor.create!(semester: DisciplineMonitor.semesters.values.sample,
                                year: Faker::Number.between(2015, 2018),
                                description: Faker::Lorem.characters(10),
                                academic: Academic.all.sample,
                                monitor_type: MonitorType.all.sample,
                                professor_ids: [Professor.all.sample.id],
                                discipline_ids: [Discipline.all.sample.id])
    end
    10.times do
      Company.find_or_create_by!(name: Faker::Name.name,
                                 image: Faker::Avatar.image,
                                 operation: Faker::Markdown.sandwich,
                                 site: Faker::Internet.url)
    end

    ts = %w[Preenchida Dispónivel Cancelada]
    ts.each do |status|
      TraineeStatus.find_or_create_by!(name: status)
    end

    10.times do
      Trainee.find_or_create_by!(title: Faker::Name.name,
                                 description: Faker::Markdown.sandwich,
                                 company: Company.all.sample,
                                 trainee_status: TraineeStatus.all.sample)
    end

    start_date = Faker::Date.between(1.year.ago, 5.months.ago)
    #########
    #  @type Activity
    #######

    desc = Faker::Lorem.paragraph(2)
    tcc_activity = Activity.create_with(description: desc)
                           .find_or_create_by!(name: I18n.t('helpers.tcc'))

    trainee_activity = Activity.create_with(description: desc)
                               .find_or_create_by!(name: I18n.t('helpers.trainee'))

    monitor_activity = Activity.create_with(description: desc)
                               .find_or_create_by!(name: I18n.t('helpers.monitor'))

    extension_activity = Activity.create_with(description: desc)
                                 .find_or_create_by!(name: I18n.t('helpers.extension_activity'))

    #########
    #  @type StaticPage
    #######

    StaticPage.create_with(
      sub_title: 'Vagas de Estágio',
      content: '## conteudo',
      permalink: 'trainee',
      activity_id: trainee_activity,
      fixed: true
    ).find_or_create_by!(
      title: I18n.t('helpers.trainee')
    )

    StaticPage.create_with(
      sub_title: 'Vagas de Monitoria',
      content: '## conteudo',
      permalink: 'monitor',
      activity_id: monitor_activity,
      fixed: true
    ).find_or_create_by!(
      title: I18n.t('helpers.monitor')
    )

    StaticPage.create_with(
      content: '## conteudo',
      permalink: 'tcc',
      activity_id: tcc_activity,
      fixed: true
    ).find_or_create_by!(
      title: I18n.t('helpers.tcc')
    )

    StaticPage.create_with(
      content: '## conteudo',
      permalink: 'extension_activity',
      activity_id: extension_activity,
      fixed: true
    ).find_or_create_by!(
      title: I18n.t('helpers.extension_activity')
    )

    StaticPage.create_with(
      content: '## conteudo',
      permalink: 'instruction_subscription',
      fixed: true
    ).find_or_create_by!(
      title: I18n.t('helpers.instruction_subscription')
    )

    StaticPage.create_with(
      content: '## conteudo',
      permalink: 'be_our_student',
      fixed: true
    ).find_or_create_by!(
      title: I18n.t('helpers.be_our_student')
    )

    StaticPage.create_with(
      content: '## conteudo',
      permalink: 'course_about',
      fixed: true
    ).find_or_create_by!(
      title: I18n.t('helpers.course_about')
    )

    ActivityProfessor.find_or_create_by!(
      professor: Professor.all.sample,
      activity: trainee_activity,
      start_date: start_date
    )
    ActivityProfessor.find_or_create_by!(
      professor: Professor.all.sample,
      activity: monitor_activity,
      start_date: start_date
    )
    ActivityProfessor.find_or_create_by!(
      professor: Professor.all.sample,
      activity: tcc_activity,
      start_date: start_date
    )
    ActivityProfessor.find_or_create_by!(
      professor: Professor.all.sample,
      activity: extension_activity,
      start_date: start_date
    )
    galleries = %w[course static_page]
    galleries.each do |context|
      Gallery.create!(context: context)
    end

    Gallery.all.each do |gallery|
      5.times do
        gallery.pictures.create! label: Faker::Lorem.paragraph(1),
                                 image: FileSpecHelper.image
      end
    end
  end
end
