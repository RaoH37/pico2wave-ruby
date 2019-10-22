require 'tempfile'

module Pico2Wave
  class Speech
    attr_reader :options, :text

    def initialize(text, options = {})
      @text = text
      @options = options
      @tmpfile = Tempfile.new(['pico', '.wav'])
      @tmpfile.close
    end

    def speak
      save
      play
    end

    def save
      line = pico2wave_command(command_options).join(' ')
      system(line)
    end

    private

    def command_options
      default_options.merge(symbolize_keys(options))
    end

    def default_options
      {
        l: 'fr-FR',
        w: @tmpfile.path
      }
    end

    def pico2wave_command(options)
      [Pico2Wave::Common.which('pico2wave')] + map_command_options(options) + [%Q{"#{@text}"}]
    end

    def map_command_options(options)
      options.map { |k,v| ["-#{k}",v].join(' ') }
    end

    def symbolize_keys(hash)
      hash.inject({}) do |options, (key, value)|
        options[(key.to_sym rescue key) || key] = value
        options
      end
    end

    def play
      p = Play.new(@tmpfile.path)
      p.run!
    end
  end
end