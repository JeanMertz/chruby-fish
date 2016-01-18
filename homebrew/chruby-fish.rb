require 'formula'

class ChrubyFish < Formula
  desc "Thin wrapper around chruby to make it work with the Fish shell"
  homepage "https://github.com/JeanMertz/chruby-fish#readme"
  url "https://github.com/JeanMertz/chruby-fish/archive/v0.7.1.tar.gz"
  sha256 "bb2159c37ec77eae76314630c0feb48bde5c4ce1fefa8f1460a7c8ffaacf7bc2"
  head "https://github.com/JeanMertz/chruby-fish.git"

  depends_on "chruby" => :recommended

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end
end
