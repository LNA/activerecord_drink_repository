class Guest
  attr_accessor :first_name, :last_name, :id, :drinks, :guests, :reposotory

  def initialize(params = {})
    @first_name = params[:first_name]
    @last_name = params[:last_name]
    @drinks = []
  end

  def update(params = {})
    @first_name = params[:first_name] if params[:first_name]
    @last_name = params[:last_name] if params[:last_name]
    add_drink_to_user(params[:drink_id])
  end

  def add_drink_to_user(drink_id)
    drink = Repository.for(:drink).find_by_id(drink_id.to_i)
    @drinks << drink if drink
  end 
end

