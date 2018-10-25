namespace :db do
  namespace :populate do
    desc 'Erase and fill static_pages table'
    task static_page: :environment do

      StaticPage.delete_all

      10.times do
        StaticPage.create!(
          title: Faker::Name.name,
          sub_title: Faker::Name.name,
          permalink: Faker::Name.unique.name.parameterize,
          content: Faker::Markdown.sandwich
        )
      end
    end
  end
end
