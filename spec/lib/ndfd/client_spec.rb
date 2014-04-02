require 'spec_helper'

describe WeatherForecasts::Client do
  subject { WeatherForecasts.client }

  let(:options) { double }

  describe "#soap_client" do
    it "returns a soap client" do
      subject.soap_client.should be_a(Savon::Client)
    end
  end

  describe "#select" do
    it "returns as WeatherForecasts::Client::SelectQuery object" do
      subject.select(options).should be_a(WeatherForecasts::Client::SelectQuery)
    end
  end

  describe "#select_by_days" do
    it "returns as WeatherForecasts::Client::SelectByDaysQuery object" do
      subject.select_by_days.should be_a(WeatherForecasts::Client::SelectByDaysQuery)
    end
  end

  describe "#select_coordinates_by_zip" do
    it "returns as WeatherForecasts::Client::SelectCoordinatesByZipQuery object" do
      subject.select_coordinates_by_zip.should be_a(WeatherForecasts::Client::SelectCoordinatesByZipQuery)
    end
  end

  describe "#select_gridpoint_coordinates" do
    it "returns as WeatherForecasts::Client::SelectGridpointCoordinatesQuery object" do
      subject.select_gridpoint_coordinates.should be_a(WeatherForecasts::Client::SelectGridpointCoordinatesQuery)
    end
  end

  describe "#select_linepoint_coordinates" do
    it "returns as WeatherForecasts::Client::SelectLinepointCoordinatesQuery object" do
      subject.select_linepoint_coordinates.should be_a(WeatherForecasts::Client::SelectLinepointCoordinatesQuery)
    end
  end

  describe "#select_cities_coordinates" do
    it "returns as WeatherForecasts::Client::SelectCitiesCoordinatesQuery object" do
      subject.select_coordinates_by_cities.should be_a(WeatherForecasts::Client::SelectCoordinatesByCitiesQuery)
    end
  end

  describe "#select_corner_coordinates" do
    it "returns as WeatherForecasts::Client::SelectCornerCoordinatesQuery object" do
      subject.select_corner_coordinates.should be_a(WeatherForecasts::Client::SelectCornerCoordinatesQuery)
    end
  end

  describe "#select_square_coordinates" do
    it "returns as WeatherForecasts::Client::SelectSquareCoordinatesQuery object" do
      subject.select_square_coordinates.should be_a(WeatherForecasts::Client::SelectSquareCoordinatesQuery)
    end
  end
end
