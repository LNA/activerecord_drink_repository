$: << File.expand_path(File.dirname(__FILE__)) + '/lib'
Dir[File.dirname(__FILE__) + '/lib/models/*.rb'].each {|file| require file }

require 'sinatra'
require 'sinatra/activerecord'
require './environment'
require './seed'
require './ar_drink'
require './ar_guest'

# AR::Seed.drinks
# Seed.guests

class DrinkApp < Sinatra::Application
  get '/' do
    'Welcome to Drink App.'
  end

  get '/drinks/new' do
    erb '/drinks/new'.to_sym
  end

  post '/drinks' do
    @drink = AR::Drink.new(params)
    @drink.save
    erb '/drinks/show'.to_sym
  end

  get '/drinks' do 
    @drinks = AR::Drink.all
    erb 'drinks/index'.to_sym
  end

  get '/drink/:id' do
    id = params[:id].to_i
    @drink = AR::Drink.find_by_id(id)
    erb '/drinks/show'.to_sym
  end

  put '/drink/:id' do
    id = params[:id].to_i
    @drink = AR::Drink.find_by_id(id)
    @drink.update_attributes(:booze => params[:booze])
    @drink.update_attributes(:mixer => params[:mixer])
    @drink.update_attributes(:glass => params[:glass])
    @drink.update_attributes(:name => params[:name])
    @drink.save
    erb 'drinks/show'.to_sym
  end

  get '/drink/:id/edit' do
    id = params[:id].to_i
    @drink = AR::Drink.find_by_id(id)
    erb '/drinks/edit'.to_sym
  end

  delete '/drink/:id' do
    id = params[:id].to_i
    @drink = AR::Drink.find_by_id(id)
    @drink.destroy
    redirect '/drinks'
  end

  get '/guests/new' do
    erb '/guests/new'.to_sym
  end

  post '/guests' do
    @guest = AR::Guest.new(params)
    @guest.save
    erb '/guests/show'.to_sym
  end

  get '/guests' do
    @guests = AR::Guest.all
    erb 'guests/index'.to_sym
  end

  get '/guest/:id' do
    id = params[:id].to_i
    @guest = AR::Guest.find_by_id(id)
    erb '/guests/show'.to_sym
  end

  put '/guest/:id' do
    id = params[:id].to_i
    @guest = AR::Guest.find_by_id(id)
    @guest.update_attributes(:first_name => params[:first_name])
    @guest.update_attributes(:last_name => params[:last_name])
    @guest.save
    redirect "/guest/#{id}"
  end

  get '/guest/:id/edit' do
    id = params[:id].to_i
    @guest = AR::Guest.find_by_id(id)
    erb '/guests/edit'.to_sym
  end

  delete '/guest/:id' do
    id = params[:id].to_i
    @guest = AR::Guest.delete_by_id(id)
    @guest.destroy
    redirect '/guests'
  end
end