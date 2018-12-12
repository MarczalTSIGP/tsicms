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
  {name: 'Especialista', abbrev: 'Esp.'},
  {name: 'Mestre', abbrev: 'Me.'},
  {name: 'Doutor', abbrev: 'Dr.'}
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
trainee_activity = Activity.create_with(description: 'descricao').find_or_create_by!(
  name: I18n.t('helpers.trainee')
)
monitor_activity = Activity.create_with(description: 'descricao').find_or_create_by!(
  name: I18n.t('helpers.monitor')
)
extension_activity = Activity.create_with(description: 'descricao').find_or_create_by!(
  name: I18n.t('helpers.extension_activity')
)

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
  title: I18n.t('helpers.extension_activity'),
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
gallery_contexts = %w[course static_page]
gallery_contexts.each do |context|
  Gallery.find_or_create_by!(context: context)
end
