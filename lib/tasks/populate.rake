# Reference: @see http://marczal.com/files/DW5/2018-1/book/#cid45

namespace :db do

  desc "Erase and fill database"
  task :populate => :environment do

    [].each(&:delete_all)
  end
end