module AR
  class Seed
    def self.drinks
      @drink1 = AR::Drink.new(:booze => "vodka", :mixer => "water", :glass => "rocks",:name => "drink1")
      @drink2 = AR::Drink.new(:booze => "gin", :mixer => "tonic", :glass => "tall",:name => "drink2" )
      @drink3 = AR::Drink.new(:booze => "ryb", :mixer => "sour", :glass => "tall",:name => "drink3")

      [@drink1, @drink2, @drink3].each do |drink|
        drink.save
      end
    end

    # def self.guests
    #   @guest1 = Guest.new(:first_name => "Tina", :last_name => "Turner")
    #   @guest2 = Guest.new(:first_name => "Miles", :last_name => "Davis" )
    #   @guest3 = Guest.new(:first_name => "Oprah", :last_name => "Winfrey")

    #   [@guest1, @guest2, @guest3].each do |guest|
    #     AR::Drink.create
    #   end
    # end
  end
end