# frozen_string_literal: true

require_relative 'options_resolver'

module VueRailsFormBuilder
  class FormBuilder < ActionView::Helpers::FormBuilder
    include VueRailsFormBuilder::OptionsResolver

    def initialize(object_name, object, template, options)
      @camelize = options[:camelize]
      @camelize = VueRailsFormBuilder.configuration.camelize if @camelize.nil?

      super(object_name, object, template, options)
    end

    (field_helpers - %i[label check_box radio_button fields_for file_field])
      .each do |selector|
      class_eval <<-RUBY_EVAL, __FILE__, __LINE__ + 1
        def #{selector}(method, options = {})
          resolve_vue_options(options)
          add_v_model_attribute(method, options, @camelize)
          super(method, options)
        end
      RUBY_EVAL
    end

    def label(method, text = nil, options = {}, &block)
      resolve_vue_options(options)
      super(method, text, options, &block)
    end

    def check_box(method, options = {}, checked_value = '1', unchecked_value = '0')
      resolve_vue_options(options)
      add_v_model_attribute(method, options, @camelize)
      super(method, options, checked_value, unchecked_value)
    end

    def radio_button(method, tag_value, options = {})
      resolve_vue_options(options)
      add_v_model_attribute(method, options, @camelize)
      super(method, tag_value, options)
    end

    def select(method, choices = nil, options = {}, html_options = {}, &block)
      resolve_vue_options(html_options)
      add_v_model_attribute(method, options, @camelize)
      super(method, choices, options, html_options, &block)
    end

    def file_field(method, options = {})
      resolve_vue_options(options)
      super(method, options)
    end

    def submit(value = nil, options = {})
      resolve_vue_options(options)
      super(value, options)
    end

    def button(value = nil, options = {}, &block)
      resolve_vue_options(options)
      super(value, options, &block)
    end

    def vue_prefix
      path = @object_name.tr('[', '.').delete(']').split('.')
      path[0] = @options[:vue_scope] if @options[:vue_scope]
      path.join('.').gsub(/\.(\d+)/, '[\1]')
    end
  end
end
