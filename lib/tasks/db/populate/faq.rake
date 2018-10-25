namespace :db do
  namespace :populate do
    desc 'Erase and fill faqs table'
    task faq: :environment do

      Faq.delete_all

      10.times do
        Faq.create!(
          title: Faker::Name.unique.name,
          answer: Faker::Markdown.random
        )
      end
    end
  end
end
