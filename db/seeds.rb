Admin.create_with(name: 'Administrador', password: '123456').find_or_create_by!(email: 'admin@admin.com')

categories = %w(Documentário Filme Livro Seriado)
categories.each do |category|
  CategoryRecommendation.find_or_create_by!(name: category)
end

professorCategories = %w[Efetivo Temporário]
professorCategories.each do |category|
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
