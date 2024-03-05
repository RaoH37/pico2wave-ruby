# pico2wave-ruby

pico2wave-ruby is a small Ruby API for utilizing [svoxpico](https://doc.ubuntu-fr.org/svoxpico) to create Text-To-Speech wav files.

## Install

Add _pico2wave-ruby_ to Gemfile

```ruby
gem "pico2wave-ruby", require: "pico2wave"
```

## Examples


```ruby
# Speaks "YO!"
speech = Pico2Wave::Speech.new("Hello!")
speech.speak # invokes pico2wave + play
```

## Installing dependencies

### Ubuntu

```shell
apt install libttspico-utils
apt install sox
```


## Licence

pico2wave-ruby is released under the [GPL v3 License](http://www.gnu.org/licenses/gpl-3.0.html).
