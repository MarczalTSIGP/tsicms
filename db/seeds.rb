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

treinee_status = %w[Preenchida Disponivel Cancelada]
treinee_status.each do |status|
  TraineeStatus.find_or_create_by!(name: status)
end
