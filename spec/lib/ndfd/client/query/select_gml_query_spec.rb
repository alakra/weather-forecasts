require 'spec_helper'

describe NDFD::Client::SelectGmlQuery do
  let(:dimension) { :maxt }
  let(:conditions) {
    {
      :feature        => "NdfdMultiPointCoverage",
      :coordinates    => [ {:latitude => 38.99, :longitude => -77.01 }],
      :requested_time => (Time.zone.now + 1.day)
    }
  }

  let(:null_logger)  { Logger.new(File.open("/dev/null", "w")) }

  subject { NDFD.client(:logger => null_logger).select_gml(dimension) }

  before(:each) do
    # Silence HTTPI logger (used by Savon)
    HTTPI.logger = null_logger
  end

  describe "#execute" do
    before(:each) do
      VCR.use_cassette('select_gml_query') do
        @response = subject.where(conditions).execute
      end
    end

    it "returns a valid response" do
      @response.should be_a(Nokogiri::XML::Document)
      @response.xpath('//app:MaximumTemperature').should be_present
    end
  end
end
