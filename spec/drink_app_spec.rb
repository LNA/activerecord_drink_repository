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

  describe 'Drinks pages' do
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
      post '/drinks'
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

    it 'returns the drink id' do
      get '/drink/1'
      last_response.should be_ok
    end

    it 'fetches the drink by id' do
      AR::Drink.should_receive(:find_by_id).with(@drink.id)
      put 'drink/#{@drink.id}'
    end

    it 'updates a specific drink' do
      new_params = {:booze =>"rum"}
      put 'drink/#{@drink.id}', new_params
      @drink.reload
      @drink.booze.should == 'rum'
    end

    it 'renders the show page after updating a drink' do
      put 'drink/#{@drink.id}'
      last_response.should be_ok
    end

    # it 'loads a specific drink for the delete view' do
    #   # How do I get it to the delete view??? 
    #   AR::Drink.should_receive(:find_by_id).with(@drink.id)
    #   delete "drink/#{@drink.id}/delete"
    # end

    it 'succesfully renders the show page' do
      get "drink/#{@drink.id}"
      last_response.should be_ok
    end

    it 'deletes the drink by id' do
      delete "/#{@drink.id}/delete"
      AR::Drink.find_by_id(@drink.id).should == nil
    end

    it 'succesfully redirects to the drink index page after delete' do
      delete "/#{@drink.id}"
      last_response.should be_redirect
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
      Guest.should_receive(:new)
      post '/guests'
    end
  
    it 'sends a new guest object to the datastore' do
      mock = MockDatastore.new
      Repository.should_receive(:for).and_return(mock)
      post '/guests', @params
      mock.item.first_name.should == 'Jay'
    end

    it 'saves a new guest object to the datastore' do
      Repository.for(:guest).save(@guest)
      post '/guests'
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
      @guest= Guest.new(params)
      Repository.for(:guest).save(@guest)
    end

    it 'returns the guest id' do
      Repository.should_receive(:for).and_return(:id)
      post '/guests'
    end

    it 'fetches the guest to update from the repository' do
      Repository.for(:guest).should_receive(:find_by_id).with(1)
      put "guest/1"
    end

    it 'updates a specific guest' do
      params = {"first_name" =>"Cindy", "splat"=>[], "captures"=>["#{@guest.id}"], "id"=>"#{@guest.id}"}
      @guest.should_receive(:update).with(params)
      put "guest/#{@guest.id}", params
    end

    it 'renders the show page after updating a guest' do
      put "guest/#{@guest.id}"
      last_response.should be_redirect
    end

    it 'loads a specific guest for the delete view' do
      Repository.for(:guest).should_receive(:find_by_id).with(@guest.id)
      get "guest/#{@guest.id}/delete"
    end

    it 'sucessfully renders the delete page' do
      get "guest/#{@guest.id}/delete"
      last_response.should be_ok
    end

    it 'deletes a guest by id' do
      delete "guest/#{@guest.id}"
      Repository.for(:guest).find_by_id(@guest.id).should == nil
    end

    it 'successfully redirects to the guest index page after delete' do
      delete "guest/#{@guest.id}"
      last_response.should be_redirect
    end
  end
end