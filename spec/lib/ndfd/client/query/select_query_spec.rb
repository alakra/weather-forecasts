require 'spec_helper'

describe NDFD::Client::SelectQuery do
  let(:dimension) { :maxt }
  let(:conditions) {
    {
      :coordinates => [ {:latitude => 38.99, :longitude => -77.01 }],
      :product     => "time-series",
      :start_time  => Time.zone.now,
      :end_time    => Time.zone.now + 6.days,
      :unit        => "e"
    }
  }

  let(:null_logger)  { Logger.new(File.open("/dev/null", "w")) }

  subject { NDFD.client(:logger => null_logger).select(dimension) }

  before(:each) do
    # Silence HTTPI logger (used by Savon)
    HTTPI.logger = null_logger
  end

  describe "#execute" do
    before(:each) do
      VCR.use_cassette('select_query') do
        @response = subject.where(conditions).execute
      end
    end

    it "returns a valid response" do
      @response.should be_a(Hash)
      @response["data"]["parameters"]["temperature"]["maximum"]["name"].should == "Daily Maximum Temperature"
    end
  end
end
