require 'spec_helper'

describe LocationsHelper do
  let(:lat) { 43.086443 }
  let(:lng) { -89.372817 }
  let(:location) { Location.new(latitude: lat, longitude: lng) }
  let(:other_location) { Location.new(latitude: lat + 1, longitude: lng + 1) }

  describe 'distance_in_words' do
    it 'returns the distance in mi between two geocoded objects' do
      distance_in_words(location, other_location).should match(/\d+\.\d\ mi/)
    end
  end
end
