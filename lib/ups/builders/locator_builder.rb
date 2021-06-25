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
    end
  end
end
