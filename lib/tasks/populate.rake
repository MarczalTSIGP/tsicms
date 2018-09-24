namespace :db do
  desc 'Erase and fill database'
  task populate: :environment do
    [CategoryRecommendation, Recommendation, Academic].each(&:destroy_all)

    categories = %w(Documentário Filme Livro Seriado)
    categories.each do |category|
      CategoryRecommendation.create!(name: category)
    end

    CategoryRecommendation.all.each do |category|
      5.times do
        category.recommendations.create! title: Faker::Name.name,
          description: Faker::Lorem.paragraph(2),
          image: File.open(Dir["#{Rails.root}/spec/samples/images/*"].sample)
      end
    end

    6.times do
      Academic.create!(
        name: Faker::Name.name,
        image: File.open(Dir["#{Rails.root}/spec/samples/images/*"].sample),
        contact: Faker::Internet.url,
        graduated: [true, false].sample
      )
    end
  end
end