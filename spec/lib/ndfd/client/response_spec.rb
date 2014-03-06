require 'spec_helper'

#
# NOTE: Values manually extracted from sample_document.xml to ensure the XSLT transform works
#############################################################################################

describe NDFD::Client::Response do
  let(:raw_document) { File.read(File.join(NDFD.root_path, "spec/support/resources/sample_document.xml")) }

  subject { NDFD::Client::Response }

  describe ".transform" do
    let(:latitude)                    { 38.99 }
    let(:longitude)                   { -77.01 }
    let(:name_of_parameter)           { "Daily Maximum Temperature" }
    let(:unit)                        { "Fahrenheit" }
    let(:number_of_periods)           { 8 }
    let(:first_start_time)            { "2014-02-26T07:00:00-05:00"  }
    let(:first_duration)              { 24 }
    let(:first_max_temperature_value) { 35 }

    it "returns the transformed XML (a max temperature response) as a Ruby hash object" do
      results = subject.transform(raw_document)

      results['data']['location']['latitude'].should == latitude
      results['data']['location']['longitude'].should == longitude

      results['data']['parameters']['temperature']['maximum']['name'].should == name_of_parameter
      results['data']['parameters']['temperature']['maximum']['units'].should == unit
      results['data']['parameters']['temperature']['maximum']['periods'].length.should == number_of_periods

      first_period = results['data']['parameters']['temperature']['maximum']['periods'].first
      first_period['start-time'].should     == first_start_time
      first_period['duration-hours'].should == first_duration
      first_period['value'].should          == first_max_temperature_value
    end
  end
end
