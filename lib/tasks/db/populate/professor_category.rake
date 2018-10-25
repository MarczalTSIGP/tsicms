namespace :db do
  namespace :populate do
    desc 'Erase and fill professor_categories table'
    task professor_category: :environment do

      ProfessorCategory.delete_all

      categories = %w[Efetivo Temporário]
      categories.each do |category|
        ProfessorCategory.create!(name: category)
      end
    end
  end
end
