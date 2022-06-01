# chruby-fish

`chruby` re-implemented for the [Fish shell](https://fishshell.com). You do not need the original `chruby` installed.

[![CI](https://github.com/JeanMertz/chruby-fish/actions/workflows/ci.yml/badge.svg)](https://github.com/JeanMertz/chruby-fish/actions/workflows/ci.yml)

## Install

```sh
wget -O chruby-fish-1.0.0.tar.gz https://github.com/JeanMertz/chruby-fish/archive/v1.0.0.tar.gz
tar -xzvf chruby-fish-1.0.0.tar.gz
cd chruby-fish-1.0.0/
sudo make install

# You might want to set this too so that fish autoloads correctly:
set -U XDG_DATA_DIRS /usr/local/share
```

### Homebrew

`chruby-fish` can also be installed with [homebrew](https://brew.sh/):

```sh
brew install chruby-fish
```

Or the absolute latest chruby-fish can be installed from source:

```sh
brew install chruby-fish --HEAD
```

### Arch Linux

`chruby-fish` is included in the [AUR](https://aur.archlinux.org/packages/chruby-fish/):

```sh
yay -S chruby-fish
```

## Fish version support

This package is tested against HEAD and the latest stable version of fish.

## Configuration

The `chruby` function is in your autoload path, so you don't need to configure it.

Homebrew uses different paths for Intel and Apple Silicon based Macs, you should configure your `config.fish` file accordingly. More about it [here](https://docs.brew.sh/FAQ#why-should-i-install-homebrew-in-the-default-location).

If you use a custom install location for chruby, use the `CHRUBY_ROOT` variable to point in the right direction.

Auto-switching is enabled by default, set `CHRUBY_AUTO_DISABLE=1` if you don't want that.

For more general instructions, see the [chruby documentation](https://github.com/postmodern/chruby#chruby).

### Default Ruby

To select the default Ruby, simply set it in your fish configuration:

```sh
echo "chruby ruby-3.1.2" > ~/.config/fish/conf.d/chruby.fish
```

## License

Released under the MIT license.

Copyright, 2013, by Jean Mertz <jean@mertz.fm>.

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
