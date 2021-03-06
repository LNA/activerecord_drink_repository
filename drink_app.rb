$: << File.expand_path(File.dirname(__FILE__)) + '/lib'
Dir[File.dirname(__FILE__) + '/lib/models/*.rb'].each {|file| require file }

require 'sinatra'
require 'sinatra/activerecord'
require './environment'
require 'ar_drink'
require 'ar_guest'
require 'ar_orders'

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
    find_drink_by_id
    erb '/drinks/show'.to_sym
  end

  put '/drink/:id' do
    find_drink_by_id
    update_drink_attributes
    @drink.save
    erb 'drinks/show'.to_sym
  end

  get '/drink/:id/edit' do
    find_drink_by_id
    erb '/drinks/edit'.to_sym
  end

  delete '/drink/:id' do
    find_drink_by_id
    @drink.destroy
    redirect '/drinks'
  end

  get '/guests/new' do
    erb '/guests/new'.to_sym
  end

  post '/guests' do
    @guest = AR::Guest.new(params)
    @guest.save
    redirect '/guests'.to_sym
  end

  get '/guests' do
    @guests = AR::Guest.all
    @drinks = AR::Drink.all
    erb 'guests/index'.to_sym
  end

  get '/guest/:id' do
    find_guest_by_id
    @drinks = AR::Drink.order("lower(name)")
    erb '/guests/show'.to_sym
  end

  put '/guest/:id' do
    find_guest_by_id
    update_guest_attributes
    @guest.save
    redirect "/guest/#{id}"
  end

  get '/guest/:id/edit' do
    find_guest_by_id
    erb '/guests/edit'.to_sym
  end

  delete '/guest/:id' do
    find_guest_by_id
    @guest.destroy
    redirect '/guests'
  end

  put '/orders/:guest_id/:drink_id' do
    guest_id = params[:guest_id]
    drink_id = params[:drink_id]
    order = AR::Orders.find_or_create_by(guest_id: guest_id, drink_id: drink_id)
    order.quantity += 1
    order.save
    redirect "/guest/#{guest_id}"
  end

  delete '/orders/:guest_id/:drink_id' do
    guest_id = params[:guest_id]
    drink_id = params[:drink_id]
    @order = AR::Orders.find_by(guest_id: guest_id, drink_id: drink_id)
    check_quantity
    redirect "/guest/#{guest_id}"
  end

  private

  def find_drink_by_id
    id = params[:id].to_i
    @drink = AR::Drink.find_by_id(id)
  end

  def find_guest_by_id
    id = params[:id].to_i
    @guest = AR::Guest.find_by_id(id)
  end

  def update_drink_attributes
    @drink.update_attributes(:booze => params[:booze],
                             :mixer => params[:mixer],
                             :glass => params[:glass], 
                             :name =>  params[:name])
  end

  def update_guest_attributes
    @guest.update_attributes(:first_name => params[:first_name],
                             :last_name => params[:last_name])
  end

  def check_quantity
    if @order.quantity == 1
      @order.destroy
    else
      @order.quantity -= 1
      @order.save
    end
  end
end