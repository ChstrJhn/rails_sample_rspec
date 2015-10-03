require 'rails_helper'
require 'spec_helper'

describe User do

  before do 
  	@user = User.new(name: "Chester", email: "chester@gmail.com",
                     password: "111222333", password_confirmation: "111222333")
  end

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }

  it { should be_valid }

  describe "when name is not present" do
  	before { @user.name = "" }
  	it {should_not be_valid}
  end

  describe "when name is too long" do
  	before { @user.name = "a" * 51 }
  	it { should_not be_valid }
  end

  describe "when email format is invalid" do
  	it "should be invalid" do
  	  addresses = %w[user@goo,com user_foo.org example.user@foo]
  	  addresses.each do |invalid_email|
  	  	@user.email = invalid_email
  	  	expect(@user).not_to be_valid
  	  end
  	end
  end

  describe "when email format is valid" do
  	it "should be valid" do
  	  addresses = %w[user@goo.com user_foo@foo.org user@example.com]
  	  addresses.each do |valid_email|
  	  	@user.email = valid_email
  	  	expect(@user).to be_valid
  	  end
  	end
  end

  describe "when email already taken" do
  	before do
  	  user_with_same_email = @user.dup
  	  user_with_same_email.save
  	end

  	it { should_not be_valid }
  end

  describe "when password is not present" do
    before do
    @user = User.new(name: "Chester", email: "chester@gmail.com",
                     password: "", password_confirmation: "")
    end
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "with a pasword that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5}
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email)}

    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

    it { should_not eq user_for_invalid_password }
    specify { expect(user_for_invalid_password).to be false }
  end
end

end