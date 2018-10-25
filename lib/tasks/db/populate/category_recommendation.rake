namespace :db do
  namespace :populate do
    desc 'Erase and fill category_recommendations table'
    task category_recommendation: :environment do

      CategoryRecommendation.delete_all

      categories = %w[Documentário Filme Livro Seriado]
      categories.each do |category|
        CategoryRecommendation.create! name: category
      end
    end
  end
end
