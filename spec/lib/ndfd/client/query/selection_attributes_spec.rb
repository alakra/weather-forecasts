require 'spec_helper'

describe NDFD::Client::SelectionAttributes do
  let(:attr) { :blah }

  subject { NDFD::Client::SelectionAttributes.new(attr) }

  describe "#valid?" do
    it "raises an error if an invalid selection attribute is used" do
      expect { subject.valid?(:wrong) }.to raise_error(NDFD::Client::InvalidSelectionAttributeError)
    end
  end
end
