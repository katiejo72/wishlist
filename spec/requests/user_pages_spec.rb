require 'spec_helper'

describe "UserPages" do
  
  subject { page }

  describe "signup page" do
  	before { visit signup_path}

  	it { should have_content('Sign Up') }
  	it { should have_title(full_title('Sign Up')) }
  end

  describe "profile page" do
  	let(:user) { FactoryGirl.create(:user) }
  	before { visit user_path(user) }

  	it { should have_content(user.fname + ' ' + user.lname) }
  	it { should have_title(user.fname + ' ' + user.lname) }
  end

  describe "signup" do
  	before { visit signup_path }

  	let(:submit) { "Allons-y" }

  	describe "with invalid information" do
  		it "should not create a user" do
  			expect { click_button submit }.not_to change(User, :count)
  		end
  	end

  	describe "with valid information" do
  		before do
  			fill_in "Fname",			with: "Example"
  			fill_in "Lname",			with: "User"
  			fill_in "Email",					with: "user@example.com"
  			fill_in "Password",				with: "foobarbaz"
  			fill_in "Password confirmation",		with: "foobarbaz"
  		end
  	
  		it "should create a user" do
  			expect { click_button submit }.to change(User, :count).by(1)
  		end
  	end
  end
end
