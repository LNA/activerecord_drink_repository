require './drink_app'
require 'sinatra/activerecord/rake'

namespace :db do
  desc "Migrate the database"
  task(:migrate) do
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    ActiveRecord::Migration.verbose = true
    ActiveRecord::Migrator.migrate("db/migrate")
  end
end