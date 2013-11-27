require 'spec_helper'

describe "StaticPages" do
  describe "Home Page" do
    it "should have the content 'Wishlist'" do
      visit '/static_pages/home'
      expect(page).to have_content('Wishlist')
    end

    it "should have the base title" do
    	visit '/static_pages/home'
    	expect(page).to have_title("Wishlist")
    end

    it "should not have a custom page title" do
      visit '/static_pages/home'
      expect(page).not_to have_title('| Home')
    end
  end
end
