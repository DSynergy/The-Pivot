FactoryGirl.define do
  factory :listing do
    title  "Bacon Maple Crunch"
    description  "see title"
    price  8.00
    quantity_available  2
    people_per_unit  2
    private_bathroom  true
    user_id  2
    country  'USA'
    state  'Colorado'
    city  'Denver'
    zipcode '80206'
    street_address '1510 Blake St'
    status 0
  end
end
