require 'spec_helper'

describe "LocationPages" do
  subject { page }
  before { BikeShareClient.stub(:parsed_json) { KioskResults.example } }

  describe 'new' do
    before do
      visit root_path
    end

    let (:submit) { "Find nearby Kiosks" }

    describe "searching for an non-existant address" do
      before do
        Geocoder::Lookup::Test.add_stub("no address", [])
        fill_in "location_address", with: "no address"
      end

      it "warns when location isn't found" do
        click_button submit
        expect(page).to have_selector('div.alert.alert-error')
      end

      describe 'after submission' do
        it 'should not create a Location' do
          expect{ click_button submit }.not_to change(Location, :count)
        end
      end
    end

    describe "searching for an address" do
      before do
        fill_in "location_address", with: "ny, ny" # default Geocode stub is in spec_helper
      end

      it 'should create a Location object' do
        expect{ click_button submit }.to change(Location, :count).by(1)
      end
    end
  end

  describe 'show' do
    before do
      visit root_path
      location =  Location.create(latitude: 39.73339, longitude: -104.98753)
      visit location_path(location)
    end

    it { should have_content "Station" }
    it { should have_content "Open Docks" }
    it { should have_content "Bikes" }
  end
end
