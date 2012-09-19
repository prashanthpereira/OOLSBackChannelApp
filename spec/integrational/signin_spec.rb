require 'spec_helper'

describe "Home page" do
    it "should have the content 'Home' " do
      visit '/signin'
      page.should have_content('Home')
    end

    #Make sure your factory generates a valid user for your authentication system
    let(:user) { Factory(:user) }

    before do
      visit '/signin'
    #  click 'Sign In'
    end

    describe 'with valid credentials' do

      #Fill in the form with the user’s credentials and submit it.
      before do
        fill_in 'Username', :with => user.name
        fill_in 'Password', :with => 'password'
      end

    end
end
