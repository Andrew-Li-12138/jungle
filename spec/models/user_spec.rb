require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
   it "is not valid when user has no email" do
    user = User.new(
      name: "testUser",
      password: "password",
      password_confirmation: "password"
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
     password_confirmation: "password"
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
      name: "testUser",
      email: 'test@example.com', 
      password: 'password',
      password_confirmation: "password"
    )
    user = User.new(
      name: "testUser",
      email: 'TEST@example.com', 
      password: 'password',
      password_confirmation: "password"
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

   # -------------------------------------------------------------------------------------- #

   describe '.authenticate_with_credentials' do
    it "return a user when password and email matches" do
      user = User.create(
        name: "testUser",
        email: 'test@example.com', 
        password: 'password',
        password_confirmation: "password"
      )
    user_with_matching_credentials = User.authenticate_with_credentials('test@example.com','password')
    expect(user_with_matching_credentials).to eq(user)
    end
    
    it "return nil when password and email don't match" do
      user = User.create(
        name: "testUser",
        email: 'test@example.com', 
        password: 'password',
        password_confirmation: "password"
      )
    user_with_unmatching_credentials = User.authenticate_with_credentials('test@example.com', 'wrongpassword')
    expect(user_with_unmatching_credentials).to be(nil)
    end

    it "return nil when client forgets to enter email" do
      user = User.create(
        name: "testUser",
        email: 'test@example.com', 
        password: 'password',
        password_confirmation: "password"
      )
    user_with_empty_email = User.authenticate_with_credentials('', 'password')
    expect(user_with_empty_email).to be(nil)
    end

    it "return nil when user forgets to enter password" do
      user = User.create(
        name: "testUser",
        email: 'test@example.com', 
        password: 'password',
        password_confirmation: "password"
      )
    user_with_empty_password = User.authenticate_with_credentials('test@example.com', '')
    expect(user_with_empty_password).to be(nil)
    end

    it "return nil when user enters non-exist email" do
    user_with_non_exist_email = User.authenticate_with_credentials('nonexistemail@test.com', 'password')
    expect(user_with_non_exist_email).to be(nil)
    end

    it "should allow spaces before and after email input" do 
      user = User.create(
        name: "testUser",
        email: 'test@example.com', 
        password: 'password',
        password_confirmation: "password"
      )
      user_with_spaces_around_email = User.authenticate_with_credentials('  test@example.com  ','password')
    expect(user_with_spaces_around_email).to eq(user)
    end

    it "should allow email input that ignores differences between uppercase and lowercase" do 
      user = User.create(
        name: "example",
        email: 'eXample@domain.COM', 
        password: 'password',
        password_confirmation: "password"
      )
      user_with_spaces_around_email = User.authenticate_with_credentials('EXAMPLe@DOMAIN.CoM','password')
    expect(user_with_spaces_around_email).to eq(user)
    end
    
   end
 end
end
