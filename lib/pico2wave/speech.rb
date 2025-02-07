# frozen_string_literal: true

require 'logger'
require 'securerandom'
require 'tempfile'

module Pico2Wave
  class Speech
    attr_writer :tmp_wav_path, :logger

    def initialize(text)
      @text = text
      yield(self) if block_given?
    end

    def speak
      if save == PICO_STEP_IDLE
        play
        true
      else
        logger.error 'an error has been detected in the generation of the .wav file'
        false
      end
    ensure
      File.unlink(tmp_wav_path)
    end

    def save
      Pico2Wave::Maker.new(@text, tmp_wav_path).make
    end

    def tmp_wav_path
      return @tmp_wav_path if defined?(@tmp_wav_path)

      @tmp_wav_path = File.join(Dir.tmpdir, "pico-#{SecureRandom.hex(4)}.wav").tap do |path|
        FileUtils.touch path
      end
    end

    def logger
      return @logger if defined?(@logger)

      @logger = Logger.new($stdout)
    end

    private

    def play
      Play.new(tmp_wav_path).run!
    end
  end
end
