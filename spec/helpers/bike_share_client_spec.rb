require 'spec_helper'
require 'vcr_helper'
require_relative '../../app/helpers/bike_share_client'
require_relative '../../app/helpers/bike_share_result'

describe BikeShareClient do

  before do
    VCR.use_cassette("bike_results") do
      @result =  BikeShareClient.get
    end
  end

  describe '.get' do
    it 'returns an Array of BikeShareClient objects' do
      @result.should be_kind_of Array
      @result.first.should be_kind_of BikeShareResult
    end
  end


  describe BikeShareResult do
    subject { @result.first }
    it  { should respond_to(:to_hash) }
  end

  describe 'creating a Kiosk object from a BikeShareResult object' do
    it 'can be used to create valid Kiosk objects ' do
      Kiosk.create(@result.first.to_hash).should  be_valid
    end
  end
end
