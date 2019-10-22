module Pico2Wave
  class Play
    def initialize(file_path)
      @file_path = file_path
    end

    def run!
      system(play_command)
    end

    private

    def play_command
      [Pico2Wave::Common.which('play'), @file_path, '>/dev/null 2>&1'].join(' ')
    end
  end
end