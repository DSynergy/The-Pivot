require 'rails_helper'

RSpec.describe Listing, type: :model do
  let(:listing) { create(:listing, title: "Bacon Maple Crunch",
                                   description: "see title",
                                   price: 8.00,
                                   quantity_available: 2,
                                   people_per_unit: 2,
                                   private_bathroom: true,
                                   start_date: "08/10/2015",
                                   end_date: "08/10/2015",
                                   user_id: 2,
                                   country: 'USA',
                                   state: 'Colorado',
                                   city: 'Denver',
                                   zipcode: '80206',
                                   street_address: '1510 Blake St',
                                   status: 0)}

  it "is valid" do
    expect(listing).to be_valid
  end

  it "is invalid without a title" do
    listing.title = nil
    expect(listing).not_to be_valid
  end

  it "is invalid without a description" do
    listing.description = nil
    expect(listing).not_to be_valid
  end

  it "must have unique title" do
    listing
    expect { create(:listing, title: "Bacon Maple Crunch") }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "not retired by default" do
    expect(listing.retired).to be false
  end

  it "has a decimal price, greater than zero" do
    expect { create(:listing, price: 0) }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "is invalid with a description over 300 characters" do
    expect { create(:listing, description: "xxxx"*100)}.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'must have a quanitity available' do
    expect { create(:listing, quantity_available: nil)}.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'must have a quantity be greater than 0' do
    expect { create(:listing, quantity_available: 0)}.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'must have people per unit' do
    expect { create(:listing, people_per_unit: nil)}.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'must have people per unit be greater than 0' do
    expect { create(:listing, people_per_unit: 0)}.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'must have people per unit' do
    expect { create(:listing, people_per_unit: nil)}.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'must have private bathroom status' do
    expect { create(:listing, private_bathroom: nil)}.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'must have available dates' do
    expect { create(:listing, start_date: nil, end_date:nil)}.to raise_error(ActiveRecord::RecordInvalid)
  end

  xit 'has the correct dates' do
    expect(listing.available_count).to be 4
  end

  it 'must belong to a user' do
    expect { create(:listing, user_id: nil)}.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'must have a city' do
    expect { create(:listing, city: nil)}.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'must have a state' do
    expect { create(:listing, state: nil)}.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'must have country' do
    expect { create(:listing, country: nil)}.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'must have a zipcode' do
    expect { create(:listing, zipcode: nil)}.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'must have available dates' do
    expect(listing.end_date).to eq '08/10/2015'
    expect(listing.start_date).to eq '08/10/2015'
  end

  # describe ".active_listings" do
  #   it "returns all active listings" do
  #     listing
  #     create(:listing, title: "Test Toast")
  #     create(:listing, title: "Lazy Toast", retired: true)
  #
  #     expect(listing.count).to eq(3)
  #     expect(listing.active_listings.count).to eq(2)
  #   end
  # end

end
