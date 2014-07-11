require 'rails_helper'

describe Listing do
  describe 'associations tests:' do
    it 'has a title' do 
      expect(@listing1.title).to eq("Beautiful Apartment on Main Street")
    end

    it 'has a description' do
      expect(@listing3.description).to eq("Whole house for rent on mountain. Many bedrooms.")
    end

    it 'has an address' do 
      expect(@listing1.address).to eq('123 Main Street')
    end

    it 'has a listing type' do 
      expect(@listing2.listing_type).to eq("shared room")
    end

    it 'has a price' do
      expect(@listing2.price).to eq(15.00) 
    end

    it 'belongs to a neighborhood' do 
      expect(@listing2.neighborhood.name).to eq('Green Point')
    end

    it 'belongs to a host' do 
      expect(@listing2.host.name).to eq('Katie')
    end

    it 'has many reviews' do 
      expect(@listing4.reviews).to include(@review3)
    end

    it 'has many reservations' do
      vaca_res = Reservation.create(checkin: '2015-03-15', checkout: '2015-03-20', listing_id: @listing3.id, guest_id: 2)
      staycation = Reservation.create(checkin: '2015-04-10', checkout: '2015-04-15', listing_id: @listing3.id, guest_id: 1)
      expect(@listing3.reservations).to include(vaca_res)
      expect(@listing3.reservations).to include(staycation)
    end

    it 'knows about all of its guests' do 
      vaca_res = Reservation.create(checkin: '2015-03-15', checkout: '2015-03-20', listing_id: @listing3.id, guest_id: 1)
      staycation = Reservation.create(checkin: '2015-04-10', checkout: '2015-04-15', listing_id: @listing3.id, guest_id: 2)
      expect(@listing3.guests.collect{|g| g.id }).to include(1)
      expect(@listing3.guests.collect{|g| g.id }).to include(2)
    end
  end

  describe 'listing validations' do 
    it 'is invalid without an address' do
      no_addy = Listing.new(listing_type: "private room", title: "Beautiful Apartment on Main Street", description: "My apartment is great. there's a bedroom. close to subway....blah blah", price: "50.00", neighborhood_id: Neighborhood.first.id, host_id: User.first.id) 
      expect(no_addy).to_not be_valid
    end

    it 'is invalid without a listing type' do 
      no_type = Listing.new(address: '123 Main Street', title: "Beautiful Apartment on Main Street", description: "My apartment is great. there's a bedroom. close to subway....blah blah", price: "50.00", neighborhood_id: Neighborhood.first.id, host_id: User.first.id) 
      expect(no_type).to_not be_valid
    end

    it 'is invalid without a title' do 
      no_title = Listing.new(address: '123 Main Street', listing_type: "shared room", description: "My apartment is great. there's a bedroom. close to subway....blah blah", price: "50.00", neighborhood_id: Neighborhood.first.id, host_id: User.first.id) 
      expect(no_title).to_not be_valid
    end

    it 'is invalid without a description' do
      no_desc = Listing.new(address: '6 Maple Street', listing_type: "shared room", title: "Shared room in apartment", price: "15.00", neighborhood_id: Neighborhood.find_by(id: 2).id, host_id: User.find_by(id: 2).id)
      expect(no_desc).to_not be_valid
    end

    it 'is invalid without a price' do
      no_price = Listing.new(address: '6 Maple Street', listing_type: "shared room", title: "Shared room in apartment", description: "shared a room with me because I'm poor", neighborhood_id: Neighborhood.find_by(id: 2).id, host_id: User.find_by(id: 2).id)
      expect(no_price).to_not be_valid
    end

    it 'is invalid without an associated neighborhood' do 
      no_nabe = Listing.new(address: '6 Maple Street', listing_type: "shared room", title: "Shared room in apartment", description: "shared a room with me because I'm poor", price: "15.00", host_id: User.find_by(id: 2).id)
      expect(no_nabe).to_not be_valid
    end

  end

  describe 'callback methods' do 
    xit 'changes user host status when created' do 
    end

    xit 'changes host status when deleted and host has no more listings' do 
    end
  end 

  describe 'instance methods' do 
    xit 'knows its average ratings from its reviews' do 
    end
  end
end
