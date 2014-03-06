require 'spec_helper'

describe NDFD::Client::SelectCoordinatesByCitiesQuery do
  let(:conditions) {
    {
      :display => :all
    }
  }

  let(:null_logger)  { Logger.new(File.open("/dev/null", "w")) }

  subject { NDFD.client(:logger => null_logger).select_coordinates_by_cities }

  # Silence savon's HTTP request logger
  before(:each) do
    HTTPI.logger = null_logger
  end

  describe "#execute" do
    before(:each) do
      VCR.use_cassette('select_coordinates_by_cities_query') do
        @response = subject.where(conditions).execute
      end
    end

    it "returns a valid response" do
      @response.should be_a(Hash)
      @response["Denver,CO"].values.each do |value|
        value.should be_a(Numeric)
      end
    end
  end
end
