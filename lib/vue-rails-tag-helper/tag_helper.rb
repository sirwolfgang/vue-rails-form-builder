# frozen_string_literal: true

module VueRailsTagHelper
  module TagHelper
    VUE_PREFIXES = ['data', 'model', :data, :model].to_set

    def self.included(_base)
      ActionView::Helpers::TagHelper::TAG_PREFIXES.add('v')
      ActionView::Helpers::TagHelper::TAG_PREFIXES.add(:v)
    end

    class TagBuilder < ActionView::Helpers::TagHelper::TagBuilder
      def tag_options(options, escape = true)
        options = options.with_indifferent_access

        if options[:v] && VueRailsTagHelper.configuration.camelize
          options[:v].each_pair do |key, value|
            next unless VUE_PREFIXES.include?(key)
            options[:v][key] = camelize(value)
          end
        end

        if options.dig(:v, :data)
          options[:data] ||= {}
          options[:data].merge!(options[:v].delete(:data))
        end

        super(options, escape)
      end

      def camelize(value)
        value = value.as_json

        if value.is_a?(String)
          value.camelize(:lower)
        elsif value.is_a?(Hash)
          value.deep_transform_keys do |key|
            key.camelize(:lower)
          end
        else
          value
        end
      end
    end

    private

    def tag_builder
      @tag_builder ||= TagBuilder.new(self)
    end
  end
end
