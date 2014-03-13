require 'spec_helper'

describe NDFD::Client::SelectQuery do
  let(:dimensions) {
    # NOTE: Adding all dimensions to ensure it doesn't blow up when parsing
    [ :maxt,:mint,:temp,:dew,:appt,:pop12,:qpf,:snow,:sky,:rh,:wspd,:wdir,:wx,:icons,
      :waveh,:incw34,:incw50,:incw64,:cumw34,:cumw50,:cumw64,:wgust,:critfireo,:dryfireo,
      :conhazo,:ptornado,:phail,:ptstmwinds,:pxtornado,:pxhail,:pxtstmwinds,:ptotsvrtstm,
      :pxtotsvrtstm,:tmpabv14d,:tmpblw14d,:tmpabv30d,:tmpblw30d,:tmpabv90d,:tmpblw90d,
      :prcpabv14d,:prcpblw14d,:prcpabv30d,:prcpblw30d,:prcpabv90d,:prcpblw90d,:precipa_r,
      :sky_r,:td_r,:temp_r,:wdir_r,:wspd_r,:wwa,:iceaccum,:maxrh,:minrh ]
  }

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

  subject { NDFD.client(:logger => null_logger).select(*dimensions) }

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

    # TODO: Add verification for each metric
    it "returns a valid response" do
      @response.should be_a(Hash)
      @response[:parameters]["point1"][:temperature][:maximum][:name].should == "Daily Maximum Temperature"
    end
  end
end
