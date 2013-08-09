require 'spec_helper'

describe "LocationPages" do
  subject { page }

  describe 'new' do
    before { visit root_path }
    let (:submit) { "Find nearby Kiosks" }

    describe "searching for an non-existant address" do
      before do
        Geocoder::Lookup::Test.add_stub("no address", [])
        fill_in "Address", with: "no address"
      end
      xit { should have_content('error') }

      describe 'after submission' do
        before { click_button submit }
        it 'should not create a Location' do
          expect{ click_button submit }.not_to change(Location, :count)
        end
      end
    end

    describe "searching for an address" do
      before do
        fill_in "Address", with: "ny, ny" # default stub in spec_helper
      end

      it 'should create a Location object' do
        expect{ click_button submit }.to change(Location, :count).by(1)
      end
    end
  end

  describe 'show' do
  end
end
