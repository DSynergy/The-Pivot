FactoryGirl.define do
  factory :user do
    username "Sally"
    email_address "sadsal@example.com"
    password "password"
    role 0
    credit_card '1234-5678-9012-3456'
    billing_address 'blahblahblah'
  end

  factory :admin, class: User do
    username "Richard"
    email_address "belieber@example.com"
    password "password"
    role 1
  end
end
