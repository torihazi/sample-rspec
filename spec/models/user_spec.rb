require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  # pendingってなんでしょうね。
  # とりあえず describeというのがまとまりなのかな
  it "is valid with a first name, last name, email, and password" do
    user = User.new(
      first_name: "John",
      last_name: "Doe",
      email: "john.doe@example.com",
      password: "password"
    )
    expect(user).to be_valid
  end

  it "is invalid without a first name" do
    user = User.new(first_name: nil)
    user.valid?
    expect(user.errors[:first_name]).to include("can't be blank")
  end

  it "is invalid without a last name" do
    user = User.new(last_name: nil)
    user.valid?
    expect(user.errors[:last_name]).to include("can't be blank")
  end

  it "is invalid without an email" do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it "is invalid with a duplicate email" do
    User.create(
      first_name: "John",
      last_name: "Doe",
      email: "john.doe@example.com",
      password: "password"
    )
    user = User.new(email: "john.doe@example.com")
  end

  it "returns a user's full name as a string" do
    user = User.new(first_name: "John", last_name: "Doe")
    expect(user.full_name).to eq("John Doe")
  end
end
