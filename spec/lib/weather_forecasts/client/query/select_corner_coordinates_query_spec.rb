require 'spec_helper'

describe WeatherForecasts::Client::SelectCornerCoordinatesQuery do
  let(:conditions) {
    {
      :sector => :conus
    }
  }

  let(:null_logger)  { Logger.new(File.open("/dev/null", "w")) }

  subject { WeatherForecasts.client(:logger => null_logger).select_corner_coordinates }

  # Silence savon's HTTP request logger
  before(:each) do
    HTTPI.logger = null_logger
  end

  describe "#execute" do
    before(:each) do
      VCR.use_cassette('select_corner_coordinates_query') do
        @response = subject.where(conditions).execute
      end
    end

    it "returns a valid response" do
      expect(@response).to be_a(Array)

      expect(@response.first.keys).to include(:latitude, :longitude)
      @response.first.values.each do |value|
        expect(value).to be_a(Numeric)
      end
    end
  end
end
