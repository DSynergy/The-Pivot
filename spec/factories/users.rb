FactoryGirl.define do
  factory :user do
    username "Sally"
    email_address "sadsal@example.com"
    password "password"
    role 0
  end

  factory :admin, class: User do
    username "Richard"
    email_address "belieber@example.com"
    password "password"
    role 1
  end
end
