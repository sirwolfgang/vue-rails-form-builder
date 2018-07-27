# frozen_string_literal: true

require 'vue-rails-form-builder/configuration'
require 'vue-rails-form-builder/form_builder'
require 'vue-rails-form-builder/railtie'

module VueRailsFormBuilder
  def self.configuration
    @configuration ||= Configuration.new.freeze
  end

  # Creates/sets a new configuration for the gem, yield a configuration object
  # @param new_configuration [Configuration] new configuration
  # @return [Configuration] the frozen configuration
  def self.configure(new_configuration = Configuration.new)
    yield(new_configuration) if block_given?

    @configuration = new_configuration.freeze
  end
end
