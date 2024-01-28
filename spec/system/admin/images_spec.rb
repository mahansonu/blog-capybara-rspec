require 'rails_helper'

RSpec.describe "Images" do
  let(:user) {create(:user)}
  let(:img) {Image.last}

  before do
    login_as(user)
  end

  describe "index" do
    before do
      create(:image)
    end

    it "renders images" do
      
    end
  end
end