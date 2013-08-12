require 'spec_helper'

describe Kiosk do
  let(:lat) { 43.086443 }
  let(:lng) { -89.372817 }
  let(:kiosk) { Kiosk.new(latitude: lat, longitude: lng) }

  subject { kiosk }

  it { should respond_to :address }
  it { should respond_to :to_gmap }

  it 'is invalid without latitude' do
    Kiosk.create(longitude: lng).should_not be_valid
  end

  it 'is invalid without longitude' do
    Kiosk.create(latitude: lat).should_not be_valid
  end

  describe '.to_coordinates' do
    it 'returns an Array of [latitude, longitude]' do
      kiosk.to_coordinates.should == [lat, lng]
    end
  end

  describe 'status css helper' do
    it "is 'danger' when the status is not 'Active'" do
      kiosk.update(status: "Unavailable")
      kiosk.status_to_css.should == "error"
    end

    it 'is warning when there are no open docks' do
      kiosk.update(status: "Active", docks_available: 0)
      kiosk.status_to_css.should == "error"
    end

    it 'is warning when there is one open dock' do
      kiosk.update(status: "Active", docks_available: 1)
      kiosk.status_to_css.should == "warning"
    end
  end

end
