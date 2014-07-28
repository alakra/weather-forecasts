require 'spec_helper'

describe WeatherForecasts::Client::SelectGridpointCoordinatesQuery do
  let(:conditions) {
    {
      :lower_left_coordinate  => { :latitude => 39.547101, :longitude => -105.215759 },
      :upper_right_coordinate => { :latitude => 39.991484, :longitude => -104.704895 },
      :resolution             => 2
    }
  }

  let(:null_logger)  { Logger.new(File.open("/dev/null", "w")) }

  subject { WeatherForecasts.client(:logger => null_logger).select_gridpoint_coordinates }

  # Silence savon's HTTP request logger
  before(:each) do
    HTTPI.logger = null_logger
  end

  describe "#execute" do
    before(:each) do
      VCR.use_cassette('select_gridpoint_coordinates_query') do
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
