require 'formula'

class ChrubyFish < Formula
  desc "Thin wrapper around chruby to make it work with the Fish shell"
  homepage "https://github.com/JeanMertz/chruby-fish#readme"
  url "https://github.com/JeanMertz/chruby-fish/archive/v0.7.0.tar.gz"
  sha256 "8d74471f75c7cd90ff319092afe9520c79ed7ff982b6025507f68ac862dc0526"
  head "https://github.com/JeanMertz/chruby-fish.git"

  depends_on "chruby" => :recommended

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end
end
