Admin.create_with(name: 'Administrador', password: '123456').find_or_create_by!(email: 'admin@admin.com')

categories = %w(Documentário Filme Livro Seriado)
categories.each do |category|
  CategoryRecommendation.find_or_create_by!(name: category)
end
