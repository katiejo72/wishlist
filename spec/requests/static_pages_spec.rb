require 'spec_helper'

describe "StaticPages" do
  describe "Home Page" do
    it "should have the content 'Wishlist'" do
      visit '/static_pages/home'
      expect(page).to have_content('Wishlist')
    end

    it "should have the right title" do
    	visit '/static_pages/home'
    	expect(page).to have_title("Wishlist | Home")
    end
  end
end
