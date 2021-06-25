module UPS
  module Parsers
    class LocatorsParser < BaseParser

      def location_informations
        locations.map do |location|
          LocatorParser.new(location).to_h
        end
      end

      private

      def locations
        normalize_response_into_array(root_response[:SearchResults][:DropLocation])
      end

      def root_response
        parsed_response[:LocatorResponse]
      end
    end
  end
end
