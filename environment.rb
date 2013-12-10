configure :test do 
	ActiveRecord::Base.establish_connection(
  :adapter  => "sqlite3",
  :database => "drink_app_test.sqlite3"
)
end

configure :development do
	ActiveRecord::Base.establish_connection(
  :adapter  => "sqlite3",
  :database => "drink_app_development.sqlite3"
	)
end