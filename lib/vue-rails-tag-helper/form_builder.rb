# frozen_string_literal: true

module VueRailsTagHelper
  class FormBuilder < ActionView::Helpers::FormBuilder
    def initialize(object_name, object, template, options)
      options[:html][:v] = options.delete(:v) if options[:v]
      super(object_name, object, template, options)
    end

    (field_helpers - %i[label check_box radio_button fields_for file_field])
      .each do |selector|
      class_eval <<-RUBY_EVAL, __FILE__, __LINE__ + 1
        def #{selector}(method, options = {})
          add_vue_model(method, options)
          super(method, options)
        end
      RUBY_EVAL
    end

    def check_box(method, options = {}, checked_value = '1', unchecked_value = '0')
      add_vue_model(method, options)
      super(method, options, checked_value, unchecked_value)
    end

    def radio_button(method, tag_value, options = {})
      add_vue_model(method, options)
      super(method, tag_value, options)
    end

    def select(method, choices = nil, options = {}, html_options = {}, &block)
      add_vue_model(method, options)
      super(method, choices, options, html_options, &block)
    end

    def vue_model(method = nil)
      path    = @object_name.tr('[', '.').delete(']').split('.')
      path[0] = @options[:vue_scope] if @options[:vue_scope]
      path << method if method
      path = path.join('.').gsub(/\.(\d+)/, '[\1]')
      path.camelize(:lower) if VueRailsTagHelper.configuration.camelize
    end

    private

    def add_vue_model(method, options)
      options[:v]         ||= {}
      options[:v][:model] ||= vue_model(method)
    end
  end
end
