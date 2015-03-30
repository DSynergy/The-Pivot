require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with username, password, and email address" do
    user = create(:user)

    expect(user).to be_valid
  end

  it "is invalid with missing username" do
    user = User.create(username: nil, password: "password", email_address: "example@example.com")

    expect(user).not_to be_valid
  end

  it "is invalid with missing password" do
    user = User.create(username: "Sally", password: nil, email_address: "example@example.com")

    expect(user).not_to be_valid
  end

  it "is invalid with missing email address" do
    user = User.create(username: "Sally", password: "password", email_address: nil)

    expect(user).not_to be_valid
  end

  it "cannot have a non-unique email address" do
    create(:user)
    expect { create(:user) }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "must have a normal email address format" do
    expect { create(:user, email_address: "hello") }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "cannot have a display name over 32 characters or under 2" do
    user_1 = create(:user, display_name: "wefwf")

    expect(user_1).to be_valid

    expect { create(:user, email_address: 'hello@exam.com', display_name: "wessfefhgjfhgjthgnjjjjjjjjjjjjjfhjsdfkjsdfkhsdfhfwf") }.to raise_error(ActiveRecord::RecordInvalid)

    expect { create(:user, email_address: "hey@ah.com", display_name: 'a') }.to raise_error(ActiveRecord::RecordInvalid)
  end
end
