require './drink_app'
require 'sinatra/activerecord/rake'

namespace :db do
  desc "Migrate the database"
  task(:migrate) do
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    ActiveRecord::Migration.verbose = true
    ActiveRecord::Migrator.migrate("db/migrate")
  end

  task(:test_migrate) do
  	ActiveRecord::Base.establish_connection(
		  :adapter  => "sqlite3",
		  :database => "drink_app_test.sqlite3"
		)
  	ActiveRecord::Base.logger = Logger.new(STDOUT)
    ActiveRecord::Migration.verbose = true
    ActiveRecord::Migrator.migrate("db/migrate")
  end
end

