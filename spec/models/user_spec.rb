require 'spec_helper'

describe User do
  let(:user) { User.new }
  subject { user }
  it { should respond_to :locations }

  describe "location association" do
    let(:lat) { 43.086443 }
    let(:lng) { -89.372817 }
    let(:location) { Location.create(user: user,
                                     latitude: lat,
                                     longitude: lng) }
    it "returns all assocaited locations" do
      user.locations.should =~ [location]
    end
  end
end
