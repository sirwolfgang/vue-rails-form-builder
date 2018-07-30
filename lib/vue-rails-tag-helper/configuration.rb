# frozen_string_literal: true

module VueRailsTagHelper
  class Configuration < OpenStruct
    DEFAULTS = {
      camelize: false
    }.freeze

    # Creates a new Configuration from the passed in parameters
    # @param params [Hash] configuration options
    # @return [Configuration]
    def initialize(params = {})
      super(DEFAULTS.merge(params))
    end
  end
end
