# pico2wave-ruby

Ruby wrapper for **pico2wave** TTS

## Install

Add _pico2wave-ruby_ to Gemfile

```ruby
gem "pico2wave-ruby", require: "pico2wave"
```

## Examples

### Generate .wav from text

```ruby
require 'pico2wave'
Pico2Wave::Maker.new("Hello!", "/tmp/pico-test.wav").make
```

### Generate and play text

```ruby
require 'pico2wave'
speech = Pico2Wave::Speech.new("Hello!")
speech.speak
```

## Installing dependencies

### Ubuntu

```shell
sudo apt-get install -y libttspico-utils sox
```


## Licence

pico2wave-ruby is released under the [GPL v3 License](http://www.gnu.org/licenses/gpl-3.0.html).
