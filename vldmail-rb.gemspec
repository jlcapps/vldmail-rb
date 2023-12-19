# frozen_string_literal: true

require 'rake'
require_relative 'lib/vldmail/version'

Gem::Specification.new do |spec|
  # just the lines you have to have to build the gem
  spec.name = 'vldmail-rb'
  spec.version = VldMail::VERSION
  spec.authors = ['Lee Capps']
  spec.email = ['himself@leecapps.com']
  spec.summary = 'A wrapper for the c libvldmail email validation library'
  spec.homepage = 'https://github.com/jlcapps/vldmail-rb'
  spec.license = 'MIT-0'
  spec.required_ruby_version = '>= 3.0.2'
  spec.metadata['homepage_uri'] = spec.homepage

  # these two lines make sure the c files get copied with gem installation
  # then built into a .bundle file to be required by ruby
  spec.files = FileList['lib/**/*.rb', 'ext/**/*.{rb,c,h}']
  spec.extensions = %w(ext/vldmail/extconf.rb)

  # paths for ruby code and the compile c bundle, respectively
  spec.require_paths = ['lib', 'ext/vldmail']

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
