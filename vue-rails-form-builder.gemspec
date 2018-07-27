# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vue-rails-form-builder/version'

Gem::Specification.new do |spec|
  spec.name        = 'vue-rails-form-builder'
  spec.version     = VueRailsFormBuilder::VERSION
  spec.authors     = ['Tsutomu KURODA']
  spec.email       = ['t-kuroda@oiax.jp']

  spec.homepage    = 'https://github.com/kuroda/vue-rails-form-builder'
  spec.summary     = 'A custom Rails form builder for Vue.js'
  spec.description = 'This gem provides four view helpers for Rails app: ' \
                     'vue_form_with, vue_form_for, vue_tag and vue_content_tag.'
  spec.license     = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.2.2'

  spec.add_dependency 'actionview', '>= 4.2', '< 6'
  spec.add_dependency 'railties', '>= 4.2', '< 6'
end
