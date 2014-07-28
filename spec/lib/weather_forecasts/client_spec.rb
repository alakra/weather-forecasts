require 'spec_helper'

describe WeatherForecasts::Client do
  subject { WeatherForecasts.client }

  let(:options) { double }

  describe "#soap_client" do
    it "returns a soap client" do
      expect(subject.soap_client).to be_a(Savon::Client)
    end
  end

  describe "#select" do
    it "returns as WeatherForecasts::Client::SelectQuery object" do
      expect(subject.select(options)).to be_a(WeatherForecasts::Client::SelectQuery)
    end
  end

  describe "#select_by_days" do
    it "returns as WeatherForecasts::Client::SelectByDaysQuery object" do
      expect(subject.select_by_days).to be_a(WeatherForecasts::Client::SelectByDaysQuery)
    end
  end

  describe "#select_coordinates_by_zip" do
    it "returns as WeatherForecasts::Client::SelectCoordinatesByZipQuery object" do
      expect(subject.select_coordinates_by_zip).to be_a(WeatherForecasts::Client::SelectCoordinatesByZipQuery)
    end
  end

  describe "#select_gridpoint_coordinates" do
    it "returns as WeatherForecasts::Client::SelectGridpointCoordinatesQuery object" do
      expect(subject.select_gridpoint_coordinates).to be_a(WeatherForecasts::Client::SelectGridpointCoordinatesQuery)
    end
  end

  describe "#select_linepoint_coordinates" do
    it "returns as WeatherForecasts::Client::SelectLinepointCoordinatesQuery object" do
      expect(subject.select_linepoint_coordinates).to be_a(WeatherForecasts::Client::SelectLinepointCoordinatesQuery)
    end
  end

  describe "#select_cities_coordinates" do
    it "returns as WeatherForecasts::Client::SelectCitiesCoordinatesQuery object" do
      expect(subject.select_coordinates_by_cities).to be_a(WeatherForecasts::Client::SelectCoordinatesByCitiesQuery)
    end
  end

  describe "#select_corner_coordinates" do
    it "returns as WeatherForecasts::Client::SelectCornerCoordinatesQuery object" do
      expect(subject.select_corner_coordinates).to be_a(WeatherForecasts::Client::SelectCornerCoordinatesQuery)
    end
  end

  describe "#select_square_coordinates" do
    it "returns as WeatherForecasts::Client::SelectSquareCoordinatesQuery object" do
      expect(subject.select_square_coordinates).to be_a(WeatherForecasts::Client::SelectSquareCoordinatesQuery)
    end
  end
end
