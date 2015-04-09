require 'rails_helper'

RSpec.describe Booking, type: :model do

  it "belongs to a user" do
    user = create(:user)
    booking = user.bookings.create(trip_name: 'woot')
    expect(booking.user_id).to eq(1)
  end

  it "can have a trip name!" do
    user = create(:user)
    booking = user.bookings.create(trip_name: 'woot')
    expect(booking.trip_name).to eq("woot")
  end

end
