require 'spec_helper'

describe "StaticPages" do
  subject { page }

  describe "Home Page" do
    before { visit root_path }

    it { should have_content('Wishlist') }
    it { should have_title(full_title('')) }
    it { should_not have_title('| Home') }
  end
end
