require 'rails_helper'

RSpec.describe NameCleanup do
  let(:name) {' - -Foo Bar! _ 87 --   '}
  describe ".cleanup" do
    it "cleans a name" do
      expect(NameCleanup.cleanup(name)).to eq('foo-bar-87')
    end
  end
end