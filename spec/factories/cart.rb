FactoryGirl.define do
  factory :cart do
    content '{4 => {"Jan1"=>0, "Jan2"=>0}}'

    initialize_with { new(content) }
  end
end
