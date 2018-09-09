Admin.create_with(name: 'Administrador', password: '123456').find_or_create_by!(email: 'admin@admin.com')

categories = [
  {name: 'Documentário'},
  {name: 'Filme'},
  {name: 'Livro'},
  {name: 'Seriado'},
]

categories.each do |category|
  CategoryRecommendation.create_with(name: category[:name]).find_or_create_by!(name: category[:name])
end
