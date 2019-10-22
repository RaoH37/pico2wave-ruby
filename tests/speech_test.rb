lib = File.expand_path('../lib/', __dir__)
$:.unshift lib unless $:.include?(lib)

require 'minitest/autorun'
require 'pico2wave'
require 'fileutils'

class SpeechTest < MiniTest::Unit::TestCase
  def test_speak
    FileUtils.rm_rf("test/tmp")
    FileUtils.mkdir_p("test/tmp")
    assert Pico2Wave::Speech.new("Hello!").speak
    FileUtils.rm_rf("test/tmp")
  end
end