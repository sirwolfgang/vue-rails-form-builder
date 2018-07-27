# frozen_string_literal: true

module VueRailsFormBuilder
  module VueOptionsResolver
    private def resolve_vue_options(options)
      if options[:bind].is_a?(Hash)
        h = options.delete(:bind)
        h.each do |key, value|
          options[:"v-bind:#{key}"] = value if value.is_a?(String)
        end
      end

      if options[:on].is_a?(Hash)
        h = options.delete(:on)
        h.each do |key, value|
          options[:"v-on:#{key}"] = value if value.is_a?(String)
        end
      end

      %i[checked disabled multiple readonly selected].each do |attr_name|
        if options[attr_name].is_a?(String)
          options[:"v-bind:#{attr_name}"] = options.delete(attr_name)
        end
      end

      %i[text html show if else else_if for model].each do |directive|
        if options[directive].is_a?(String)
          options[:"v-#{directive.to_s.dasherize}"] = options.delete(directive)
        end
      end

      %i[pre cloak once].each do |directive|
        if options[directive]
          options.delete(directive)
          options[:"v-#{directive}"] = "v-#{directive}"
        end
      end
    end

    private def add_v_model_attribute(method, options)
      path = @object_name.tr('[', '.').delete(']').split('.')
      path[0] = @options[:vue_scope] if @options[:vue_scope]
      options[:"v-model"] ||= (path + [method]).join('.')
      options[:"v-model"].gsub!(/\.(\d+)/, '[\1]')
    end
  end
end
