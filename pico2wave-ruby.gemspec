# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift lib unless $LOAD_PATH.include?(lib)

require 'pico2wave'

Gem::Specification.new do |gem|
  gem.name          = 'pico2wave-ruby'
  gem.version       = Pico2Wave.gem_version
  gem.date          = `date '+%Y-%m-%d'`

  gem.summary       = 'Ruby wrapper for ‘pico2wave’ TTS'
  gem.description   = 'pico2wave-ruby is small Ruby API for utilizing ‘pico2wave’ to create Text-To-Speech wav files'

  gem.author        = 'Maxime Désécot'
  gem.email         = 'maxime.desecot@gmail.com'
  gem.homepage      = 'https://github.com/RaoH37/pico2wave-ruby'
  gem.require_paths = ['lib']
  gem.license       = 'GPL-3.0'

  # ensure the gem is built out of versioned files
  gem.files = `git ls-files`.split("\n")
end
