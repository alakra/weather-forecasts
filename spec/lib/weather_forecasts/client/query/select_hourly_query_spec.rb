require 'spec_helper'

describe WeatherForecasts::Client::SelectHourlyQuery do
  let(:conditions) {
    {
      :latitude  =>  38.99,
      :longitude => -77.01
    }
  }

  subject { WeatherForecasts.client.select_hourly }

  describe "#execute" do
    before(:each) do
      VCR.use_cassette('select_hourly_query') do
        @response = subject.where(conditions).execute
      end
    end

    it "returns a valid response" do
      @response.should be_a(Hash)
      @response[:parameters]["point1"][:temperature][:hourly][:values].first[:value].should be_a(Numeric)
    end
  end
end
