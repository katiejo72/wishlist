require 'spec_helper'

describe User do
  
  before { @user = User.new(fname: "Example", lname: "User", email: "user@example.com") }

  subject { @user }

  it { should respond_to(:fname) }
  it { should respond_to(:lname) }
  it { should respond_to(:email) }

  it { should be_valid }

  describe "when fname is not present" do
  	before { @user.fname = " " }
  	it { should_not be_valid }
  end

  describe "when lname is not present" do
  	before { @user.lname = " " }
  	it { should_not be_valid }
  end

  describe "when email is not present" do
  	before { @user.email = " " }
  	it { should_not be_valid }
  end

  describe "when fname is too long" do
    before { @user.fname = "a" * 21 }
    it { should_not be_valid }
  end
end
