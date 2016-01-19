require 'formula'

class ChrubyFish < Formula
  desc "Thin wrapper around chruby to make it work with the Fish shell"
  homepage "https://github.com/JeanMertz/chruby-fish#readme"
  url "https://github.com/JeanMertz/chruby-fish/archive/v0.7.2.tar.gz"
  sha256 "d64248ce9b80dfdb327b69f4db3cfd0901957a745fd8b3b0f8c2a31fd0840297"
  head "https://github.com/JeanMertz/chruby-fish.git"

  depends_on "chruby" => :recommended

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end
end
