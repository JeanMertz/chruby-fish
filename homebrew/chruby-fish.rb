require 'formula'

class ChrubyFish < Formula
  homepage 'https://github.com/JeanMertz/chruby-fish#readme'
  url 'https://github.com/JeanMertz/chruby-fish/archive/v0.5.3.tar.gz'
  sha1 '41dfad5206a9b6cd7ac267813a1001c2bf07da8a'

  head 'https://github.com/JeanMertz/chruby-fish.git'

  depends_on 'chruby' => :recommended

  def install
    system 'make', 'install', "PREFIX=#{prefix}"
  end
end
