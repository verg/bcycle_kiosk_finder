require 'spec_helper'

describe "LocationPages" do
  subject { page }
  before { BikeShareClient.stub(:parsed_json) { KioskResults.example } }

  shared_examples "a search form" do
    let (:submit) { "Find nearby Kiosks" }

    describe "successfuly searching for an address" do
      before do
        fill_in "location_address", with: "madison, wi" # default Geocode stub is in spec_helper
        click_button submit
      end

      it { should have_content "Station" }
      it { should have_content "Open Docks" }
      it { should have_content "Bikes" }

      it 'should create a Location object' do
        fill_in "location_address", with: "madison, wi"
        expect{ click_button submit }.to change(Location, :count).by(1)
      end
    end

    describe "searching for an non-existant address" do
      before do
        Geocoder::Lookup::Test.add_stub("not an address", [])
        fill_in "location_address", with: "not an address"
      end

      it "warns when location isn't found" do
        click_button submit
        expect(page).to have_selector('div.alert.alert-error')
        expect(page).to have_content('not an address')
      end

      describe 'after submission' do
        it 'should not create a Location' do
          expect{ click_button submit }.not_to change(Location, :count)
        end
      end
    end
  end

  describe 'index' do
    before { visit root_path }
    it_behaves_like "a search form"
  end

  describe 'show' do
    let(:lat) { 43.086443 }
    let(:lng) { -89.372817 }
    let(:address) { '1 main st, city, state' }
    let(:location) { Location.create(address: address, latitude: lat, longitude: lng) }

    before { visit location_path(location) }
    it_behaves_like "a search form"

    it { should have_content "Station" }
    it { should have_content "Open Docks" }
    it { should have_content "Bikes" }
    it { should have_content "Kiosks near: #{address}" }
  end
end
