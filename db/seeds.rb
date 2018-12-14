Admin.create_with(name: 'Administrador', password: '123456')
     .find_or_create_by!(email: 'admin@admin.com')

categories = %w[Documentário Filme Livro Seriado]
categories.each do |category|
  CategoryRecommendation.find_or_create_by!(name: category)
end

professor_categories = %w[Efetivo Temporário]
professor_categories.each do |category|
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

trainee_status = %w[Preenchida Disponivel Cancelada]
trainee_status.each do |status|
  TraineeStatus.find_or_create_by!(name: status)
end

#########
#  @type Activity
#######

tcc_activity = Activity.create_with(description: 'descricao').find_or_create_by!(
  name: I18n.t('helpers.tcc')
)
trainee_activity = Activity.find_or_create_by!(
  name: I18n.t('helpers.trainee'),
  description: 'descricao'
)
monitor_activity = Activity.find_or_create_by!(
  name: I18n.t('helpers.monitor'),
  description: 'descricao'
)
extension_activity = Activity.find_or_create_by!(
  name: I18n.t('helpers.extension_activity'),
  description: 'descricao'
)

#########
#  @type StaticPage
#######

StaticPage.find_or_create_by!(
  title: I18n.t('helpers.trainee'),
  sub_title: 'Vagas de Estágio',
  content: '## conteudo',
  permalink: 'trainee',
  activity_id: trainee_activity,
  fixed: true
)

StaticPage.find_or_create_by!(
  title: I18n.t('helpers.monitor'),
  sub_title: 'Vagas de Monitoria',
  content: '## conteudo',
  permalink: 'monitor',
  activity_id: monitor_activity,
  fixed: true
)

StaticPage.find_or_create_by!(
  title: I18n.t('helpers.tcc'),
  content: '## conteudo',
  permalink: 'tcc',
  activity_id: tcc_activity,
  fixed: true
)

StaticPage.find_or_create_by!(
  title: I18n.t('helpers.extension_activity'),
  content: '## conteudo',
  permalink: 'extension_activity',
  activity_id: extension_activity,
  fixed: true
)

StaticPage.find_or_create_by!(
  title: I18n.t('helpers.instruction_subscription'),
  content: '## conteudo',
  permalink: 'instruction_subscription',
  fixed: true
)

StaticPage.find_or_create_by!(
  title: I18n.t('helpers.be_our_student'),
  content: '## conteudo',
  permalink: 'be_our_student',
  fixed: true
)

StaticPage.find_or_create_by!(
  title: I18n.t('helpers.course_about'),
  content: '## conteudo',
  permalink: 'course_about',
  fixed: true
)
gallery_contexts = %w[course static_page]
gallery_contexts.each do |context|
  Gallery.find_or_create_by!(context: context)
end
