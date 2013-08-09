require 'spec_helper'

describe Location do
  it { should respond_to :address }
  it { should respond_to :latitude }
  it { should respond_to :longitude }
  it { should respond_to :to_coordinates }
  it { should respond_to :coords_to_uri }

  let(:lat) { 43.086443 }
  let(:lng) { -89.372817 }
  let(:address) { '1 main st, city, state' }
  let(:location) { Location.new(address: address, latitude: lat, longitude: lng) }

  describe 'when latitude is not present' do
    before { Location.new(address: address, longitude: lng) }
    it { should_not be_valid }
  end

  describe 'when longitude is not present' do
    before { Location.new(address: address, latitude: lat) }
    it { should_not be_valid }
  end

  describe '.to_coordinates' do
    it 'returns an Array of [latitude, longitude]' do
      location.to_coordinates.should == [lat, lng]
    end
  end

  describe '.coords_to_uri' do
    it 'returns the relative URI' do
      location.coords_to_uri.should == "/#{lat}/#{lng}"
    end
  end
end
