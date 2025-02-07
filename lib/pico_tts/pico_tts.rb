# frozen_string_literal: true

require 'ffi'

module Pico2Wave
  extend FFI::Library
  ffi_lib 'libttspico.so.0.0.0'

  SVOX_MEMORY_SIZE = 3_145_728 # 3*1024**2
  OUT_BUFFER_SIZE = 4096
  PICO_STEP_IDLE = 200
  PICO_STEP_BUSY = 201
  GENFILE_BYTES_LIMIT = 65_536 # 2**16

  attach_function :pico_initialize, %i[pointer size_t pointer], :void
  attach_function :pico_loadResource, %i[pointer string pointer], :int
  attach_function :pico_getResourceName, %i[pointer pointer pointer], :int
  attach_function :pico_createVoiceDefinition, %i[pointer string], :void
  attach_function :pico_addResourceToVoiceDefinition, %i[pointer string pointer], :void
  attach_function :pico_newEngine, %i[pointer string pointer], :int
  attach_function :pico_putTextUtf8, %i[pointer string size_t pointer], :int
  attach_function :pico_getData, %i[pointer pointer size_t pointer pointer], :int

  class << self
    attr_writer :name, :bpath

    def bpath
      @bpath ||= '/usr/share/pico/lang'
    end

    def name
      @name ||= 'PicoVoice'
    end

    def lang_data
      @lang_data ||= 'fr-FR_ta.bin'
    end

    def lang_data=(value)
      raise Error, %(invalid lang_data "#{value}") unless lang_datas.include?(value)

      @lang_data = value
    end

    def lang_datas
      @lang_datas || Dir[File.join(bpath, '*_ta.bin')].map { |path| File.basename(path) }
    end

    def speaker_data
      @speaker_data ||= 'fr-FR_nk0_sg.bin'
    end

    def speaker_data=(value)
      raise Error, %(invalid speaker_data "#{value}") unless speaker_datas.include?(value)

      @speaker_data = value
    end

    def speaker_datas
      @speaker_datas || Dir[File.join(bpath, '*_sg.bin')].map { |path| File.basename(path) }
    end
  end
end

require_relative 'maker'
