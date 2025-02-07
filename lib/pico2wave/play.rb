# frozen_string_literal: true

module Pico2Wave
  class Play
    attr_writer :player_command

    def initialize(file_path)
      @file_path = file_path
    end

    def run!
      system(play_command)
    end

    private

    def play_command
      [player_command, @file_path, '>/dev/null 2>&1'].join(' ')
    end

    def player_command
      @player_command ||= Pico2Wave::Common.which('aplay')
    end
  end
end
