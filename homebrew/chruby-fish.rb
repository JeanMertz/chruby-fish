require 'formula'

class ChrubyFish < Formula
  homepage 'https://github.com/JeanMertz/chruby-fish#readme'
  url 'https://github.com/JeanMertz/chruby-fish/archive/v0.5.1.tar.gz'
  sha1 'b6bf11ee6a5b3a9553bceb43bf56c733d68f1dd4'

  head 'https://github.com/JeanMertz/chruby-fish.git'

  depends_on 'chruby' => :recommended

  def install
    system 'make', 'install', "PREFIX=#{prefix}"
  end

  def caveats; <<-EOS.undent
    Add the following to the ~/.config/fish/config.fish file:

      source #{opt_prefix}/share/chruby/chruby.fish

    To enable auto-switching of Rubies specified by .ruby-version files,
    add the following to ~/.config/fish/config.fish:

      source #{opt_prefix}/share/chruby/auto.fish

    See chruby documentation for more details:

      https://github.com/postmodern/chruby#chruby
    EOS
  end
end
