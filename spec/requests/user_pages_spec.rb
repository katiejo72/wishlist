require 'spec_helper'

describe "User pages" do
  
  subject { page }

  describe "index" do
    let(:user) { FactoryGirl.create(:user) }
    before(:each) do
      sign_in user
      visit users_path
    end

    it { should have_title('All Users') }
    it { should have_content('All Users') }

    describe "pagination" do
      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all) { User.delete_all }

      it { should have_selector('div.pagination') }

      it "should list each user" do
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector('li', text: user.fname + ' ' + user.lname)
        end
      end
    end

    describe "delete links" do
      it { should_not have_link('delete') }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end

        it { should have_link('exterminate', href: user_path(User.first)) }
        it "should be able to delete another user" do
          expect do
            click_link('exterminate', match: :first)
          end.to change(User, :count).by(-1)
        end

        it { should_not have_link('exterminate', href: user_path(admin)) }
        it "should not be able to delete itself" do
          expect { delete user_path(admin) }.not_to change(User, :count)
        end
      end
    end
  end

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
  			fill_in "First Name", with: "Example"
  			fill_in "Last Name", with: "User"
  			fill_in "Email", with: "user@example.com"
  			fill_in "Password", with: "foobarbaz"
  			fill_in "Confirm Password", with: "foobarbaz"
  		end
  	
  		it "should create a user" do
  			expect { click_button submit }.to change(User, :count).by(1)
  		end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }

        it { should have_link('Sign Out') }
        it { should have_title(user.fname + ' ' + user.lname) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end
  	end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_content("Update Profile") }
      it { should have_title("Edit User") }
      it { should have_link('Change', href: 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
      before { click_button "Save Changes" }

      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_fname) { "New" }
      let(:new_lname) { "Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "First Name", with: new_fname
        fill_in "Last Name", with: new_lname
        fill_in "Email", with: new_email
        fill_in "Password", with: user.password
        fill_in "Confirm Password", with: user.password
        click_button "Save Changes"
      end

      it { should have_title(new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign Out', href: signout_path) }
      specify { expect(user.reload.fname).to eq new_fname }
      specify { expect(user.reload.lname).to eq new_lname }
      specify { expect(user.reload.email).to eq new_email }
    end

    describe "forbidden attributes" do
      let(:params) do
        { user: { admin: true, password: user.password, 
                  password_confirmation: user.password } }
      end

      before do
        sign_in user, no_capybara: true
        patch user_path(user), params
      end

      specify { expect(user.reload).not_to be_admin }
    end
  end
end
