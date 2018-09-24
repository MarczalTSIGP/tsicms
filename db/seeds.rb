Admin.create_with(name: 'Administrador', password: '123456').find_or_create_by!(email: 'admin@admin.com')

categories = %w(Documentário Filme Livro Seriado)
categories.each do |category|
  CategoryRecommendation.find_or_create_by!(name: category)

end


professorCategories = %w[Efetivo Temporario]

professorCategories.each do |category|
  ProfessorCategory.find_or_create_by!(name: category)
end

titles = [
  {description: 'Especialista', abbrev: 'Esp.'},
  {description: 'Mestre', abbrev: 'Me.'},
  {description: 'Doutor', abbrev: 'Dr.'}
]

titles.each do |title|
  ProfessorTitle.find_or_create_by!(description: title[:description], abbrev: title[:abbrev])
end
