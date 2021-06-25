require 'uri'
require 'ox'

module UPS
  module Parsers
    class LocatorParser
      attr_reader :location

      def initialize(location)
        @location = location
      end

      def to_h
        {
          location_id: location_id,
          consignee_name: consignee_name
        }
      end

      private

      def location_id
        location[:LocationID]
      end

      def consignee_name
        location[:AddressKeyFormat][:ConsigneeName]
      end

    end
  end
end
