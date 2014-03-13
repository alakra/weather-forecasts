require 'multi_json'

require 'ndfd/dwml/head_extractor'
require 'ndfd/dwml/data_extractor'

#
# Note: See http://graphical.weather.gov/xml/mdl/XML/Design/MDL_XML_Design.pdf
# for authoritative type definitions
################################################################################

module NDFD
  class DWML
    attr_reader :output, :xmldoc

    def initialize(xmldoc)
      @xmldoc = xmldoc
      @output = {}
    end

    def process
      build_head
      build_data
      output
    end

    protected

    def build_head
      extractor = NDFD::DWML::HeadExtractor.new(xmldoc.xpath("//dwml/head").first)
      @output.merge!(extractor.process)
    end

    def build_data
      extractor = NDFD::DWML::DataExtractor.new(xmldoc.xpath("//dwml/data").first)
      @output.merge!(extractor.process)
    end
  end
end
