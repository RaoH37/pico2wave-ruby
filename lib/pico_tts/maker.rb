# frozen_string_literal: true

module Pico2Wave
  class Maker
    def initialize(txt, temp_wav_path)
      @genfile = %(<genfile file="#{temp_wav_path}">#{txt}</genfile>)
      test_genfile
    end

    def make
      svox_memory = FFI::MemoryPointer.new(:char, Pico2Wave::SVOX_MEMORY_SIZE)
      ps = FFI::MemoryPointer.new(:pointer)
      Pico2Wave.pico_initialize(svox_memory, Pico2Wave::SVOX_MEMORY_SIZE, ps)

      lang_res = FFI::MemoryPointer.new(:pointer)
      fpath = File.join(Pico2Wave.bpath, Pico2Wave.lang_data)
      Pico2Wave.pico_loadResource(ps.read_pointer, fpath, lang_res)

      lang_res_name = FFI::MemoryPointer.new(:char, 200)
      Pico2Wave.pico_getResourceName(ps.read_pointer, lang_res.read_pointer, lang_res_name)

      speaker_res = FFI::MemoryPointer.new(:pointer)
      npath = File.join(Pico2Wave.bpath, Pico2Wave.speaker_data)
      Pico2Wave.pico_loadResource(ps.read_pointer, npath, speaker_res)

      speaker_res_name = FFI::MemoryPointer.new(:char, 200)
      Pico2Wave.pico_getResourceName(ps.read_pointer, speaker_res.read_pointer, speaker_res_name)

      Pico2Wave.pico_createVoiceDefinition(ps.read_pointer, Pico2Wave.name)
      Pico2Wave.pico_addResourceToVoiceDefinition(ps.read_pointer, Pico2Wave.name, lang_res_name)
      Pico2Wave.pico_addResourceToVoiceDefinition(ps.read_pointer, Pico2Wave.name, speaker_res_name)

      pico_engine = FFI::MemoryPointer.new(:pointer)
      Pico2Wave.pico_newEngine(ps.read_pointer, Pico2Wave.name, pico_engine)

      bytes_sent = FFI::MemoryPointer.new(:int16)
      out_buffer = FFI::MemoryPointer.new(:char, Pico2Wave::OUT_BUFFER_SIZE)
      bytes_received = FFI::MemoryPointer.new(:int16)
      data_type = FFI::MemoryPointer.new(:int16)

      remaining = @genfile.bytesize + 1

      Pico2Wave.pico_putTextUtf8(pico_engine.read_pointer, @genfile, remaining, bytes_sent)

      status = Pico2Wave::PICO_STEP_BUSY

      while status == Pico2Wave::PICO_STEP_BUSY
        status = Pico2Wave.pico_getData(
          pico_engine.read_pointer,
          out_buffer,
          Pico2Wave::OUT_BUFFER_SIZE,
          bytes_received,
          data_type
        )
      end

      status
    end

    private

    def test_genfile
      raise Error, 'the text to convert is too long' if @genfile.bytesize > GENFILE_BYTES_LIMIT
    end
  end
end
