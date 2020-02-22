# chruby-fish

`chruby` re-implemented in `chruby-fish`.

## install

```bash
wget -O chruby-fish-0.8.2.tar.gz https://github.com/JeanMertz/chruby-fish/archive/v0.8.2.tar.gz
tar -xzvf chruby-fish-0.8.2.tar.gz
cd chruby-fish-0.8.2/
make install
```

### Homebrew

chruby-fish can also be installed with [homebrew][]:

```sh
brew install chruby-fish
```

Or the absolute latest chruby-fish can be installed from source:

```sh
brew install chruby-fish --HEAD
```

chruby is installed as a dependency of chruby-fish, if you installed chruby
manually, add the `--without-chruby` flag to the above commands.

### Arch Linux

chruby-fish is included in the [AUR](https://aur.archlinux.org/packages/chruby-fish/):

```sh
yay -S chruby-fish
```

## configuration

The `chruby` function is in your autoload path, so you don't need to configure it.

To enable auto-switching, source the `auto.fish` file:

```sh
source /usr/local/share/fish/vendor_completions.d/chruby_auto.fish
```

If you use a custom install location for chruby, use the
[`CHRUBY_ROOT` variable][chruby_root] to point in the right direction.

For more general instructions, see the [chruby documentation][].

## License & Authors

Author: Bouke van der Bijl
