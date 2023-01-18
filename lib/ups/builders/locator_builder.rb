require 'ox'

module UPS
  module Builders
    # The {LocatorBuilder} class builds UPS XML Locators Objects.
    #
    # @author Tomasz Kulik
    # @since 0.1.0
    class LocatorBuilder < BuilderBase
      include Ox

      # Initializes a new {LocatorBuilder} object
      #
      def initialize
        super 'LocatorRequest'

        add_request('Locator', '1')
      end

      # Adds OriginAddress to the locator
      #
      # @return [void]
      def add_origin_address(opts = {})
        root << Element.new('OriginAddress').tap do |origin_address|
          origin_address << Element.new('AddressKeyFormat').tap do |address_key_format|
            address_key_format << element_with_value('AddressLine', opts[:address_line]) if opts[:address_line]
            address_key_format << element_with_value('PoliticalDivision2', opts[:city]) if opts[:city]
            address_key_format << element_with_value('PoliticalDivision1', opts[:state]) if opts[:state]
            address_key_format << element_with_value('PostcodePrimaryLow', opts[:zip_code]) if opts[:zip_code]
            address_key_format << element_with_value('CountryCode', opts[:country_code]) if opts[:country_code]
          end
        end
      end

      def add_location_search_criteria(opts = {})
        root << Element.new('LocationSearchCriteria').tap do |lsc|
          lsc << Element.new('SearchOption').tap do |so|
            so << Element.new('OptionType').tap do |ot|
              ot << element_with_value('Code', opts[:option_type_code].presence || '01')
            end

            so << Element.new('OptionCode').tap do |oc|
              oc << element_with_value('Code', opts[:option_code_code].presence || '002')
            end

            lsc << element_with_value('MaximumListSize', opts[:list_size].presence || '10')
            lsc << element_with_value('SearchRadius', opts[:radius].presence || '50')
          end
        end
      end
    end
  end
end
