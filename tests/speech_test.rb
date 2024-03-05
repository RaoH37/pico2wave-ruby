# frozen_string_literal: true

lib = File.expand_path('../lib/', __dir__)
$LOAD_PATH.unshift lib unless $LOAD_PATH.include?(lib)

require 'minitest/autorun'
require 'pico2wave'
require 'fileutils'

class SpeechTest < Minitest::Test
  def test_speak
    assert Pico2Wave::Speech.new('Il est 17 heure ! vous avez 2 minutes pour quitter les lieux !').speak
  end
end
