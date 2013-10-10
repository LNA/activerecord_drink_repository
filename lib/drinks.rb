class Drinks
  attr_accessor :records, :id, :drink
# look at template and strat. method to refactor out sim methods
  def initialize
    @records = {}
    @id = 1
  end

  def save(drink)
    @records[@id] = drink
    drink.id = @id
    @id += 1
  end

  def all
  	@records.values
  end

  def find_by_id(id)
  	@records[id]
  end

  def delete_by_id(id)
     @records.delete(id)
   end
end