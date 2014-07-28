require 'spec_helper'

describe WeatherForecasts::Client::SelectLinepointCoordinatesQuery do
  let(:conditions) {
    {
      :start_coordinate => { :latitude => 39.547101, :longitude => -105.215759 },
      :stop_coordinate  => { :latitude => 39.991484, :longitude => -104.704895 }
    }
  }

  let(:null_logger)  { Logger.new(File.open("/dev/null", "w")) }

  subject { WeatherForecasts.client(:logger => null_logger).select_linepoint_coordinates }

  # Silence savon's HTTP request logger
  before(:each) do
    HTTPI.logger = null_logger
  end

  describe "#execute" do
    before(:each) do
      VCR.use_cassette('select_linepoint_coordinates_query') do
        @response = subject.where(conditions).execute
      end
    end

    it "returns a valid response" do
      @response.should be_a(Array)

      @response.first.keys.should include(:latitude, :longitude)
      @response.first.values.each do |value|
        value.should be_a(Numeric)
      end
    end
  end
end
