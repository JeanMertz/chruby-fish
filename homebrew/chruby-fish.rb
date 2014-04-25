require 'formula'

class ChrubyFish < Formula
  homepage 'https://github.com/JeanMertz/chruby-fish#readme'
  url 'https://github.com/JeanMertz/chruby-fish/archive/v0.5.3.tar.gz'
  sha1 'c38f2d68c621dcb96cd8eac32a688daa01a8f76d'

  head 'https://github.com/JeanMertz/chruby-fish.git'

  depends_on 'chruby' => :recommended

  def install
    system 'make', 'install', "PREFIX=#{prefix}"
  end
end
