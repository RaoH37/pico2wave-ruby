# frozen_string_literal: true

module Pico2Wave
  class Error < StandardError; end

  module Errors
    class << self
      def output_missing_dependencies
        case RUBY_PLATFORM
        when /darwin/
          # todo
        when /linux/
          puts "\nMissing dependencies\n" \
               "sudo apt-get install -y libttspico-utils\n\n"
        when /mswin|msys|mingw|cygwin/
          # todo
        end
      end
    end
  end
end
