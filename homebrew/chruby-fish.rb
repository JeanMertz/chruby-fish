class ChrubyFish < Formula
  desc "Thin wrapper around chruby to make it work with the Fish shell"
  homepage "https://github.com/JeanMertz/chruby-fish#readme"
  url "https://github.com/JeanMertz/chruby-fish/archive/v0.8.0.tar.gz"
  sha256 "d74fada4c4e22689d08a715a2772e73776975337640bd036fbfc01d90fbf67b7"
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
