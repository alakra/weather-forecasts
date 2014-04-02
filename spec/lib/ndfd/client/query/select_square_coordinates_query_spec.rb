require 'spec_helper'

describe WeatherForecasts::Client::SelectSquareCoordinatesQuery do
  let(:conditions) {
    {
      :center_point => { :latitude => 39.547101, :longitude => -105.215759 },
      :distance     => { :latitude => 0.547101, :longitude => 0.215759 },
      :resolution   => 10
    }
  }

  let(:null_logger)  { Logger.new(File.open("/dev/null", "w")) }

  subject { WeatherForecasts.client(:logger => null_logger).select_square_coordinates }

  # Silence savon's HTTP request logger
  before(:each) do
    HTTPI.logger = null_logger
  end

  describe "#execute" do
    before(:each) do
      VCR.use_cassette('select_square_coordinates_query') do
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
