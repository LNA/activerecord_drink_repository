require 'spec_helper'
require 'ar_guest'
require 'ar_drink'
require 'ar_orders'

describe AR::Drink do
	it "returns the drinks for a guest" do
		guest = AR::Guest.create(:first_name => "Roger")
		drink = AR::Drink.create(:name => "Rumchata", :booze => "not really")
		drink2 = AR::Drink.create(:name => "Whiskey", :booze => "Jack Daniels")
		AR::Orders.create(:guest_id => guest.id, :drink_id => drink.id)
		AR::Orders.create(:guest_id => guest.id, :drink_id => drink2.id)
		guest.drinks.should == [drink, drink2]
	end
end