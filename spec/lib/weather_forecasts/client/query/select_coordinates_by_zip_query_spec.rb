require 'spec_helper'

describe WeatherForecasts::Client::SelectCoordinatesByZipQuery do
  let(:conditions) {
    {
      :zip => ["80129", "80128"]
    }
  }

  let(:null_logger)  { Logger.new(File.open("/dev/null", "w")) }

  subject { WeatherForecasts.client(:logger => null_logger).select_coordinates_by_zip }

  # Silence savon's HTTP request logger
  before(:each) do
    HTTPI.logger = null_logger
  end

  describe "#execute" do
    before(:each) do
      VCR.use_cassette('select_coordinates_by_zip_query') do
        @response = subject.where(conditions).execute
      end
    end

    it "returns a valid response" do
      expect(@response).to be_a(Hash)
      expect(@response.keys).to include(*conditions[:zip])
      @response.each do |_, value|
        value.values.each do |v|
          expect(v).to be_a(Numeric)
        end
      end
    end
  end
end
