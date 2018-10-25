namespace :db do

  desc 'Erase and fill database'
  task populate: :environment do

    %w[
      academic
      professor_category
      professor_title
      professor
      matrix
      period
      discipline
      discipline_monitor
      category_recommendation
      recommendation
      activity
      activitiy_professor
      faq
      static_page
    ].each do |model|
      Rake::Task["db:populate:#{model}"].execute
    end
  end
end
