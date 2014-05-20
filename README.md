# chruby-fish

[![Build Status](http://img.shields.io/travis/JeanMertz/chruby-fish.svg)][travis]
[![Gittip](http://img.shields.io/gittip/JeanMertz.svg)][gittip]

Thin wrapper around [chruby][] to make it work with the [Fish shell][]

[travis]: http://travis-ci.org/JeanMertz/chruby-fish
[gittip]: https://www.gittip.com/JeanMertz
[chruby]: https://github.com/postmodern/chruby
[Fish shell]: http://fishshell.com

## install

**note** that `chruby-fish` is dependent on `chruby`, please [install it first].

```bash
wget -O chruby-fish-0.6.0.tar.gz https://github.com/JeanMertz/chruby-fish/archive/v0.6.0.tar.gz
tar -xzvf chruby-fish-0.6.0.tar.gz
cd chruby-fish-0.6.0/
sudo make install
```

[install it first]: https://github.com/postmodern/chruby#install

### Homebrew

chruby-fish can also be installed with [homebrew]:

    brew install https://raw.githubusercontent.com/JeanMertz/chruby-fish/master/homebrew/chruby-fish.rb

Or the absolute latest chruby-fish can be installed from source:

    brew install https://raw.githubusercontent.com/JeanMertz/chruby-fish/master/homebrew/chruby-fish.rb --HEAD

chruby is installed as a dependency of chruby-fish, if you installed chruby
manually, add the `--without-chruby` flag to the above commands.

[homebrew]: http://brew.sh/

## configuration

Add the following line to your `config.fish` file:

    source /usr/local/share/chruby/chruby.fish

To enable auto-switching, also add the `auto.fish` file:

    source /usr/local/share/chruby/auto.fish

If you use a custom install location for chruby, use the
[`CHRUBY_ROOT` variable][chruby_root] to point in the right direction.

For more general instructions, see the [chruby documentation][].

[chruby_root]: https://github.com/JeanMertz/chruby-fish/blob/ad62361884941067485df6c417959cdc2a42c182/share/chruby/chruby.fish#L33-L34
[chruby documentation]: https://github.com/postmodern/chruby#chruby

## License & Authors

- Author: Jean Mertz <jean@mertz.fm>

```text
The MIT License (MIT)

Copyright (c) 2014 Jean Mertz <jean@mertz.fm>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
```
