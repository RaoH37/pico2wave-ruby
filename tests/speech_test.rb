# frozen_string_literal: true

lib = File.expand_path('../lib/', __dir__)
$LOAD_PATH.unshift lib unless $LOAD_PATH.include?(lib)

require 'minitest/autorun'
require 'pico2wave'

class SpeechTest < Minitest::Test
  def test_speak
    assert Pico2Wave::Speech.new('Il est 17 heure ! vous avez 2 minutes pour quitter les lieux !').speak
  end

  def test_make
    text = "Ceci est un test, merci de votre compréhension !"
    tmp_wav_path =File.join(Dir.tmpdir, "pico-#{SecureRandom.hex(4)}.wav").tap do |path|
      FileUtils.touch path
    end

    Pico2Wave::Maker.new(text, tmp_wav_path).make

    assert File.exist?(tmp_wav_path)
  end
end
