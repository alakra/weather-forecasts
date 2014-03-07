require 'multi_json'

module NDFD
  class Client
    class Response
      DWML_TO_JSON_XSLT = File.join(NDFD.vendor_path, "noaa-dwml-to-json-xslt/noaa.xsl")

      class << self
        def transform(raw_response)
          document = Nokogiri::XML(raw_response)
          MultiJson.load( xslt.transform(document).text )
        end

        def xslt
          @@xslt ||= Nokogiri::XSLT(File.read(DWML_TO_JSON_XSLT))
        end
      end
    end
  end
end
