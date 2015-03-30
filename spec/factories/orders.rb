FactoryGirl.define do
  factory :order do
    status 0
    cart {{"1" => 3, "2" => 3, "3" => 3}}

    user
  end

end
