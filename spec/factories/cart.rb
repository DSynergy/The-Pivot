FactoryGirl.define do
  factory :cart do
    content { {4 => 3, 2 => 3, 3 => 3} }
    
    initialize_with { new(content) }
  end
end
