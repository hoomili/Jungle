require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    it 'is valid with all the values' do
      @user = User.create!({
        first_name: 'ali',
        last_name: 'gholi',
        email: 'ali@gholi.com',
        password: '123456',
        password_confirmation: '123456',
        })
      expect(@user).to be_valid
    end
    it 'is not valid without password' do
      @user = User.new({
        first_name: 'ali',
        last_name: 'gholi',
        email: 'ali@gholi.com',
        password: nil,
        password_confirmation: '123456',
        })
      @user.validate
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it 'is not valid with short (< 6 characters) password' do
      @user = User.new({
        first_name: 'ali',
        last_name: 'gholi',
        email: 'ali@gholi.com',
        password: "12345",
        password_confirmation: '12345',
        })
      @user.validate
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
    it 'is not valid without password confirmation' do
      @user = User.new({
        first_name: 'ali',
        last_name: 'gholi',
        email: 'ali@gholi.com',
        password: "123456",
        password_confirmation: nil,
        })
      @user.validate
      expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
    end
    it 'is not valid without password confirmation matching password' do
      @user = User.new({
        first_name: 'ali',
        last_name: 'gholi',
        email: 'ali@gholi.com',
        password: "123456",
        password_confirmation: "234567",
        })
      @user.validate
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it 'is not valid without first name' do
      @user = User.new({
        first_name: nil,
        last_name: 'gholi',
        email: 'ali@gholi.com',
        password: "123456",
        password_confirmation: "123456",
        })
      @user.validate
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end
    it 'is not valid without last name' do
      @user = User.new({
        first_name: "ali",
        last_name: nil,
        email: 'ali@gholi.com',
        password: "123456",
        password_confirmation: "123456",
        })
      @user.validate
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end
    it 'is not valid without last name' do
      @user = User.new({
        first_name: "ali",
        last_name: "gholi",
        email: nil,
        password: "123456",
        password_confirmation: "123456",
        })
      @user.validate
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it 'cannot enter the same email twice' do
      @user1 = User.create!({
        first_name: "ali",
        last_name: "gholi",
        email: "ali@gholi.com",
        password: "123456",
        password_confirmation: "123456",
        })

      @user2 = User.new({
        first_name: "ali",
        last_name: "gholi",
        email: "ALI@GHOLI.com",
        password: "123456",
        password_confirmation: "123456",
        })
      @user2.validate
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end
  end
  describe '.authenticate_with_credentials' do
    # examples for this class method here
    it "logs in with user email and password" do
      @user1 = User.create!({
        first_name: "ali",
        last_name: "gholi",
        email: "ali@gholi.com",
        password: "123456",
        password_confirmation: "123456",
        })
        @user1 = User.authenticate_with_credentials("ali@gholi.com", "123456")
      expect(@user1).to_not be(nil)
    end
    it "logs in if there are spaces around the user's email" do
      User.create!({
        first_name: "ali",
        last_name: "gholi",
        email: "ali@gholi.com",
        password: "123456",
        password_confirmation: "123456",
        })
      @user1 = User.authenticate_with_credentials("  ali@gholi.com  ", "123456")
      expect(@user1).to_not be(nil)
    end
    it "logs in if there are uppercase letters in user's email" do
      User.create!({
        first_name: "ali",
        last_name: "gholi",
        email: "ali@gholi.com",
        password: "123456",
        password_confirmation: "123456",
        })
      @user1 = User.authenticate_with_credentials("ALI@gholi.com", "123456")
      expect(@user1).to_not be(nil)
    end
  end
end

