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

  it 'should have a valid credit card' do
    user = create(:user)
    expect(user.credit_card).to eq '1234567890123456'
  end

  it 'cannot have an invalid credit card' do
    expect { create(:user, credit_card: 'sgd62827') }.to raise_error(ActiveRecord::RecordInvalid)
  end


  it 'can have a blank credit card' do
    expect { create(:user, credit_card: '') }.not_to raise_error
  end

  it 'can have a billing address' do
    user = create(:user)
    expect(user.billing_address).to eq 'blahblahblah'
  end

  it 'is active by default' do
    user = create(:user)
    expect(user.role).to eq 'active'
  end

  it 'can become inactive' do
    user = create(:user, role: 2)
    expect(user.role).to eq 'inactive'
  end

  it 'can be an admin' do
    user = create(:user, role: 1)
    expect(user.role).to eq 'admin'
  end


end
