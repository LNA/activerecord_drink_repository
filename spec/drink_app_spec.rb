require 'spec_helper'

describe DrinkApp do
  def app
    @app ||= DrinkApp
  end

  describe 'the home page' do
    it 'loads home page' do
      get '/' 
      last_response.should be_ok
    end
  end

  describe 'AR::Drinks pages' do
    before :each do
      @params = {:booze => 'vodka',
               :mixer => 'water',
               :glass => 'rocks',
               :name =>  'drink1'}
      @drink = AR::Drink.new(@params)
    end

    it 'displays the form for creating new drinks' do
      get '/drinks/new'
      last_response.should be_ok
    end

    it 'creates a new drink object' do
      AR::Drink.should_receive(:new)
      post '/drinks', @params 
    end

    it 'displays a list of all drinks' do
      get '/drinks'
      last_response.should be_ok
    end
  end

  describe 'Pages for a single drink' do
    before :each do
      params = {:booze => 'vodka',
               :mixer => 'water',
               :glass => 'rocks',
               :name =>  'drink1'}
      @drink = AR::Drink.new(params)
      @drink.save
    end

    context 'get drink' do
      it 'fetches the drink by id' do
        AR::Drink.should_receive(:find_by_id).with(@drink.id).and_call_original
        get "drink/#{@drink.id}"
        last_response.should be_ok
      end
    end

    context 'updating a drink' do
      it 'updates a specific drink' do
        new_params = {:booze =>"rum"}
        put "drink/#{@drink.id}", new_params
        @drink.reload
        @drink.booze.should == 'rum'
      end

      it 'renders the show page after updating a drink' do
        put "drink/#{@drink.id}"
        last_response.should be_ok
      end
    end

    context 'deleting a drink' do
      it 'loads a specific drink for the delete view' do
        AR::Drink.should_receive(:find_by_id).with(@drink.id)
        delete "drink/#{@drink.id}"
      end

      it 'succesfully renders the show page' do
        get "drink/#{@drink.id}"
        last_response.should be_ok
      end

      it 'deletes the drink by id' do
        delete "drink/#{@drink.id}"
        AR::Drink.find_by_id(@drink.id).should == nil
      end

      it 'succesfully redirects to the drink index page after delete' do
        delete "drink/#{@drink.id}"
        last_response.should be_redirect
      end
    end
  end

  describe 'Guests pages' do 

    before :each do
      params = {:first_name => 'Jay',
               :last_name => 'Crew'}
      @guest = AR::Guest.new(params)
    end

    it 'displays the new guest page' do
      get '/guests/new'
      last_response.should be_ok
    end

    it 'creates a new guest object' do
      AR::Guest.should_receive(:new)
      post '/guests'
    end

    it 'saves a new guest object' do
      params = {"first_name" => "Roger",
                "last_name" => "Rabbit"}
      AR::Guest.should_receive(:new).with(params)     
      post '/guests', params
    end

    it 'displays a list of all guests' do
      get '/guests'
      last_response.should be_ok
    end
  end

  describe 'Pages for a single guest' do

    before :each do
      params = {:first_name => 'Jay',
               :last_name => 'Crew'}
      @guest= AR::Guest.new(params)
      @guest.save
    end

    context 'get guest' do
      it 'returns the guest id' do
        AR::Guest.should_receive(:find_by_id).with(@guest.id).and_call_original
        get "guest/#{@guest.id}"
        last_response.should be_ok
      end
    end

    context 'update guest' do
      it 'updates a specific guest' do
        params = {:first_name =>"Cindy"}
        put "guest/#{@guest.id}", params
        @guest.reload
        @guest.first_name.should == "Cindy"
      end

      it 'renders the show page after updating a guest' do
        put "guest/#{@guest.id}"
        last_response.should be_redirect
      end
    end

    context 'deleting a guest' do
      it 'deletes the guest by id' do
        delete "guest/#{@guest.id}"
        AR::Guest.find_by_id(@guest.id).should == nil
      end

      it 'successfully redirects to the guest index page after delete' do
        delete "guest/#{@guest.id}"
        last_response.should be_redirect
      end
    end

    context 'guests drinks' do
      let(:params) { {:booze => 'vodka',
                      :mixer => 'water',
                      :glass => 'rocks',
                      :name =>  'drink1'} }
      let(:drink) {AR::Drink.create(params)}

      # it 'should create a drink guest relationship' do
      #   put "guest_drinks/#{@guest.id}/#{drink.id}"
      #   @guest.drinks.should include(drink)
      # end

      it 'deletes a guests drink' do
        @drinks_guest = AR::DrinksGuests.create(:guest_id => @guest.id,
                                :drink_id => drink.id)
        delete "/guest_drinks/#{@guest.id}/#{drink.id}"
        AR::DrinksGuests.find_by_drink_id_and_guest_id(drink.id, @guest.id).should == nil
      end
    end
  end
end