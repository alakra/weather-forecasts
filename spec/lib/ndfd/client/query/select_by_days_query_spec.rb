require 'spec_helper'

describe NDFD::Client::SelectByDaysQuery do
  let(:conditions) {
    {
      :coordinates => [ {:latitude => 38.99, :longitude => -77.01 }],
      :days        => 5,
      :start_date  => Time.zone.now,
      :unit        => "e",
      :format      => "24 hourly"
    }
  }

  let(:null_logger)  { Logger.new(File.open("/dev/null", "w")) }

  subject { NDFD.client(:logger => null_logger).select_by_days }

  before(:each) do
    # Silence HTTPI logger (used by Savon)
    HTTPI.logger = null_logger
  end

  describe "#execute" do
    before(:each) do
      VCR.use_cassette('select_by_days_query') do
        @response = subject.where(conditions).execute
      end
    end

    it "returns a valid response" do
      @response.should be_a(Hash)
      @response[:parameters]["point1"][:temperature][:maximum][:name].should == "Daily Maximum Temperature"
    end
  end
end
