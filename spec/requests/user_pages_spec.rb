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

      describe "after submission" do
        before { click_button submit }

        it { should have_title('Sign Up') }
        it { should have_content('error') }

        it { should have_content('Fname can\'t be blank') }
        it { should have_content('Lname can\'t be blank') }
        it { should have_content('Email can\'t be blank') }
        it { should have_content('Email is invalid') }
        it { should have_content('Password can\'t be blank') }
        it { should have_content('Password is too short (minimum is 8 characters)') }
        it { should have_content('Password confirmation can\'t be blank') }
        it { should have_content('Password confirmation doesn\'t match Password') }
      end
  	end

  	describe "with valid information" do
  		before do
  			fill_in "First name",			with: "Example"
  			fill_in "Last name",			with: "User"
  			fill_in "Email",					with: "user@example.com"
  			fill_in "Password",				with: "foobarbaz"
  			fill_in "Password confirmation",		with: "foobarbaz"
  		end
  	
  		it "should create a user" do
  			expect { click_button submit }.to change(User, :count).by(1)
  		end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }

        it { should have_title(user.fname + ' ' + user.lname) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end
  	end
  end
end
