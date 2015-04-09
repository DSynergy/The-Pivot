FactoryGirl.define do
  factory :reservation do
    listing_id 2
    booking_id 1
    user_id 3
    status 0
    start_date '05/01/2015'
    end_date '05/05/2015'
  end
end
