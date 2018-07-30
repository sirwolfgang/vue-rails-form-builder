# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vue-rails-tag-helper/version'

Gem::Specification.new do |spec|
  spec.name        = 'vue-rails-tag-helper'
  spec.version     = VueRailsTagHelper::VERSION
  spec.authors     = ['Zane Wolfgang Pickett', 'Tsutomu KURODA']
  spec.email       = ['sirwolfgang@users.noreply.github.com', 't-kuroda@oiax.jp']

  spec.homepage    = 'https://github.com/sirwolfgang/vue-rails-tag-helper'
  spec.summary     = 'A custom Rails tag helper for Vue.js'
  spec.license     = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'actionview', '>= 4.2', '< 6'
  spec.add_dependency 'railties', '>= 4.2', '< 6'
end
