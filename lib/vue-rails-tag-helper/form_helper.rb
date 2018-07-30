# frozen_string_literal: true

module VueRailsTagHelper
  module FormHelper
    def vue_form_with(**options)
      raise 'Your Rails does not implement form_with helper.' unless respond_to?(:form_with)

      options[:builder] ||= VueRailsTagHelper::FormBuilder
      if block_given?
        form_with(options, &Proc.new)
      else
        form_with(options)
      end
    end

    def vue_form_for(record, options = {}, &block)
      options[:builder] ||= VueRailsTagHelper::FormBuilder
      form_for(record, options, &block)
    end
  end
end
