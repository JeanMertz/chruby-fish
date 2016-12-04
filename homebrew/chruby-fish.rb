class ChrubyFish < Formula
  desc "Thin wrapper around chruby to make it work with the Fish shell"
  homepage "https://github.com/JeanMertz/chruby-fish#readme"
  url "https://github.com/JeanMertz/chruby-fish/archive/v0.8.1.tar.gz"
  sha256 "1a0fa95d6be5958edca31a80de3594a563de6f7d09213418db895dda6724c271"
  head "https://github.com/JeanMertz/chruby-fish.git"

  depends_on "fish" => :recommended
  depends_on "chruby" => :recommended

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    assert_match /chruby-fish/, shell_output("fish -c '. #{share}/chruby/chruby.fish; chruby --version'")
  end
end
