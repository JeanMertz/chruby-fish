require 'formula'

class ChrubyFish < Formula
  homepage 'https://github.com/JeanMertz/chruby-fish#readme'
  url 'https://github.com/JeanMertz/chruby-fish/archive/v0.5.4.tar.gz'
  sha1 'bcc27a6ea7d411ce3c47c44967f3fe27750c653f'

  head 'https://github.com/JeanMertz/chruby-fish.git'

  depends_on 'chruby' => :recommended

  def install
    system 'make', 'install', "PREFIX=#{prefix}"
  end
end
