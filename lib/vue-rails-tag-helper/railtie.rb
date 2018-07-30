# frozen_string_literal: true

require 'vue-rails-tag-helper/form_helper'
require 'vue-rails-tag-helper/tag_helper'

module VueRailsTagHelper
  class Railtie < Rails::Railtie
    initializer 'vue-rails-tag-helper.helpers' do
      ActiveSupport.on_load :action_view do
        include VueRailsTagHelper::FormHelper
        include VueRailsTagHelper::TagHelper
      end
    end
  end
end
