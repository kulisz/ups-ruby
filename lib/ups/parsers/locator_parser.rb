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
          access_point_id: access_point_id,
          consignee_name: consignee_name,
          geocode: geocode,
          address: address,
          status: status
        }
      end

      private

      def location_id
        location[:LocationID]
      end

      def consignee_name
        location.try(:[], :AddressKeyFormat).try(:[], :ConsigneeName)
      end

      def geocode
        location.try(:[], :Geocode)
      end 

      def address
        location.try(:[], :AddressKeyFormat).deep_transform_keys { |key| key.to_s.underscore }.try(:deep_symbolize_keys)
      end

      def status
        location.try(:[], :AccessPointInformation).try(:[], :AccessPointStatus).try(:[], :Description)
      end

      def access_point_id
        location.try(:[], :AccessPointInformation).try(:[], :PublicAccessPointID)
      end
    end
  end
end
