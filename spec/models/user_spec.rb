require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'Validations' do
   it "is not valid when user has no email" do
    user = User.new(
      name: "testUser",
      password: "password",
      password_confirmation: "wrongpassword"
    )
    expect(user.valid?).to be(false), "Errors: #{user.errors.full_messages.join(', ')}"
   end

   it "is not valid when user has no password" do
     user = User.new(
     name: "testUser",
     email: "test@testuser.com",
  )
   expect(user.valid?).to be(false), "Errors: #{user.errors.full_messages.join(', ')}"
  end

   it "is not valid when user has no name" do
     user = User.new(
     email: "test@testuser.com",
     password: "password",
     password_confirmation: "wrongpassword"
  )
   expect(user.valid?).to be(false), "Errors: #{user.errors.full_messages.join(', ')}"
  end

   it "validates when password and password_confirmation matches" do
    user = User.new(
      name: "testUser",
      email: "test@testuser.com",
      password: "password",
      password_confirmation: "password"
    )
    expect(user.valid?).to be(true), "Errors: #{user.errors.full_messages.join(', ')}"
   end

   it "fails to validate when password and password_confirmation don't match" do
    user = User.new(
      name: "testUser",
      email: "test@testuser.com",
      password: "password",
      password_confirmation: "wrongpassword"
    )
    expect(user.valid?).to be(false), "Errors: #{user.errors.full_messages.join(', ')}"
   end
   
   it "is not valid when email is not unique (case insensitive)" do
    test_user = User.create(
      name: "example",
      email: 'test@example.com', 
      password: 'password'
    )
    user = User.new(
      name: "example",
      email: 'TEST@example.com', 
      password: 'password'
    )
    expect(user.valid?).to be(false), "Errors: #{user.errors.full_messages.join(', ')}"
   end

   it "is not valid when password is too short" do
    user = User.new(
      name: "testUser",
      email: "test@testuser.com",
      password: "short",
      password_confirmation: "short"
    )
    expect(user.valid?).to be(false), "Errors: #{user.errors.full_messages.join(', ')}"
   end

   it "is valid when password is long enough" do
    user = User.new(
      name: "testUser",
      email: "test@testuser.com",
      password: "longenough",
      password_confirmation: "longenough"
    )
    expect(user.valid?).to be(true), "Errors: #{user.errors.full_messages.join(', ')}"
   end

  end
end
