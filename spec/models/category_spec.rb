require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { Category.create(name: "side dishes") }

  it "has valid attributes" do
    expect(category.name).to eq("side dishes")
  end

  it "is not valid without a name" do
    other_category = Category.create(name:nil)
    expect(other_category).not_to be_valid
  end

end
