require 'rails_helper'

RSpec.describe "Login Page" do
  let(:user) {create(:user)}

  it "Admin requires loging in" do
    login_as(user)
    
    click_link "Logout"
    expect(page).to have_link 'My Blog'
  end
end