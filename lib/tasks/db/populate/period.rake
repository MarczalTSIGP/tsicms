namespace :db do
  namespace :populate do
    desc 'Erase and fill periods table'
    task period: :environment do

      Period.delete_all

      Matrix.all.each do |matrix|
        6.times do |n|
          period = n + 1
          Period.create!(
            name: I18n.t("ordinal_numbers.#{period}#{period.ordinal}.m"),
            matrix: matrix
          )
        end
      end
    end
  end
end
