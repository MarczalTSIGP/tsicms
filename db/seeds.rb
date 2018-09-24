Admin.create_with(name: 'Administrador', password: '123456').find_or_create_by!(email: 'admin@admin.com')

<<<<<<< HEAD
<<<<<<< HEAD
categories = %w(Documentário Filme Livro Seriado)
categories.each do |category|
  CategoryRecommendation.find_or_create_by!(name: category)
end
=======
academics = %w(Name Image Contact Graduated)
academics.each  do |academic|
    Academic.find_or_create_by!(name: academic)
end    
>>>>>>> Altered ActiveStorage to carrierwave
=======
  

>>>>>>> Updated Seeds and Populate
