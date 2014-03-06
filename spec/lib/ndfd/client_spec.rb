require 'spec_helper'

describe NDFD::Client do
  subject { NDFD.client }

  let(:options) { double }

  describe "#soap_client" do
    it "returns a soap client" do
      subject.soap_client.should be_a(Savon::Client)
    end
  end

  describe "#select" do
    it "returns as NDFD::Client::SelectQuery object" do
      subject.select(options).should be_a(NDFD::Client::SelectQuery)
    end
  end

  describe "#select_gml" do
    it "returns as NDFD::Client::SelectGmlQuery object" do
      subject.select_gml(options).should be_a(NDFD::Client::SelectGmlQuery)
    end
  end

  describe "#select_gml_on_time_series" do
    it "returns as NDFD::Client::SelectGmlOnTimeSeriesQuery object" do
      subject.select_gml_on_time_series(options).should be_a(NDFD::Client::SelectGmlOnTimeSeriesQuery)
    end
  end

  describe "#select_by_days" do
    it "returns as NDFD::Client::SelectByDaysQuery object" do
      subject.select_by_days.should be_a(NDFD::Client::SelectByDaysQuery)
    end
  end

  describe "#select_coordinates_by_zip" do
    it "returns as NDFD::Client::SelectCoordinatesByZipQuery object" do
      subject.select_coordinates_by_zip.should be_a(NDFD::Client::SelectCoordinatesByZipQuery)
    end
  end

  describe "#select_gridpoint_coordinates" do
    it "returns as NDFD::Client::SelectGridpointCoordinatesQuery object" do
      subject.select_gridpoint_coordinates.should be_a(NDFD::Client::SelectGridpointCoordinatesQuery)
    end
  end

  describe "#select_linepoint_coordinates" do
    it "returns as NDFD::Client::SelectLinepointCoordinatesQuery object" do
      subject.select_linepoint_coordinates.should be_a(NDFD::Client::SelectLinepointCoordinatesQuery)
    end
  end

  describe "#select_cities_coordinates" do
    it "returns as NDFD::Client::SelectCitiesCoordinatesQuery object" do
      subject.select_coordinates_by_cities.should be_a(NDFD::Client::SelectCoordinatesByCitiesQuery)
    end
  end

  describe "#select_corner_coordinates" do
    it "returns as NDFD::Client::SelectCornerCoordinatesQuery object" do
      subject.select_corner_coordinates.should be_a(NDFD::Client::SelectCornerCoordinatesQuery)
    end
  end

  describe "#select_square_coordinates" do
    it "returns as NDFD::Client::SelectSquareCoordinatesQuery object" do
      subject.select_square_coordinates.should be_a(NDFD::Client::SelectSquareCoordinatesQuery)
    end
  end
end
