require 'spec_helper'

describe BikeShareClient do

  before do
    BikeShareClient.stub(:parsed_json) { KioskResults.example }
    @result =  BikeShareClient.get
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
