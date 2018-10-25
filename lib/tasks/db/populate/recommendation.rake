namespace :db do
  namespace :populate do
    desc 'Erase and fill recommendations table'
    task recommendation: :environment do

      Recommendation.delete_all

      CategoryRecommendation.all.each do |category|
        5.times do
          category.recommendations.create!(
            title: Faker::Name.name,
            description: Faker::Lorem.paragraph(2),
            image: File.open(Dir["#{Rails.root}/spec/samples/images/*"].sample)
          )
        end
      end
    end
  end
end
