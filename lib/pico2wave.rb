# frozen_string_literal: true

require 'pico2wave/version'
require 'pico2wave/errors'

module Pico2Wave
  autoload :Common, 'pico2wave/common'
  autoload :Speech, 'pico2wave/speech'
  autoload :Play, 'pico2wave/play'
end

begin
  require_relative 'pico_tts/pico_tts'
rescue LoadError => e
  puts e.message
  Pico2Wave::Errors.output_missing_dependencies
  exit(2)
end