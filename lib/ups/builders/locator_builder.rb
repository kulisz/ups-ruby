require 'ox'

module UPS
  module Builders
    # The {LocatorBuilder} class builds UPS XML Locators Objects.
    #
    # @author Tomasz Kulik
    # @since 0.1.0
    class LocatorBuilder < BuilderBase
      include Ox

      attr_accessor :opts

      # Initializes a new {LocatorBuilder} object
      #
      def initialize
        super 'LocatorRequest'

        # add_request('Locator', '64')
      end

      # Adds OriginAddress to the locator
      #
      # @return [void]
      def add_origin_address(opts = {})
        return if opts.try(:[], :origin_address).blank?

        root << Element.new('OriginAddress').tap do |origin_address|
          origin_address << Element.new('AddressKeyFormat').tap do |address_key_format|
            address_key_format << element_with_value('AddressLine', opts[:origin_address][:address_line]) if opts[:origin_address][:address_line]
            address_key_format << element_with_value('PoliticalDivision2', opts[:origin_address][:city]) if opts[:origin_address][:city]
            address_key_format << element_with_value('PoliticalDivision1', opts[:origin_address][:state]) if opts[:origin_address][:state]
            address_key_format << element_with_value('PostcodePrimaryLow', opts[:origin_address][:zip_code]) if opts[:origin_address][:zip_code]
            address_key_format << element_with_value('CountryCode', opts[:origin_address][:country_code]) if opts[:origin_address][:country_code]
          end
        end
      end

      def add_location_search_criteria(opts = {})
        return if opts.try(:[], :location_search_criteria).blank?

        root << Element.new('LocationSearchCriteria').tap do |lsc|
          lsc << add_search_option(opts[:location_search_criteria][:search_option]) if opts[:location_search_criteria][:search_option].present?
          lsc << element_with_value('MaximumListSize', opts[:location_search_criteria][:list_size].presence || '10')
          lsc << element_with_value('SearchRadius', opts[:location_search_criteria][:radius].presence || '50')
          lsc << add_access_point_search(opts[:location_search_criteria][:access_point_search]) if opts[:location_search_criteria][:access_point_search].present?
        end
      end

      def add_search_option(opts = {})
        Element.new('SearchOption').tap do |so|
          so << Element.new('OptionType').tap do |ot|
            ot << element_with_value('Code', opts[:option_type][:code]) if opts[:option_type][:code].present?
          end

          so << Element.new('OptionCode').tap do |oc|
            oc << element_with_value('Code', opts[:option_code][:code]) if opts[:option_code][:code].present?
          end
        end
      end

      def add_access_point_search(opts = {})
        Element.new('AccessPointSearch').tap do |aps|
          aps << element_with_value('PublicAccessPointID', opts[:point_id]) if opts[:point_id]
          aps << element_with_value('AccessPointStatus', opts[:status]) if opts[:status]
          aps << element_with_value('AccountNumber', opts[:account_number]) if opts[:account_number]
        end
      end
    end
  end
end
