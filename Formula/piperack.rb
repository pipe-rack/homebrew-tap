class Piperack < Formula
  desc "Concurrent command runner for developers who value their time"
  homepage "https://github.com/pipe-rack/piperack"
  version "0.2.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/pipe-rack/piperack/releases/download/v0.2.2/piperack-v0.2.2-aarch64-apple-darwin.tar.gz"
      sha256 "e4c002121dd483581dc0863124dcff0c26577782b8a4f542de873fe888a66495"
    else
      url "https://github.com/pipe-rack/piperack/releases/download/v0.2.2/piperack-v0.2.2-x86_64-apple-darwin.tar.gz"
      sha256 "450f827f73f8b070c8cba21de4f7c5caa9734d4468f58a0b3fbe70153203a2d5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/pipe-rack/piperack/releases/download/v0.2.2/piperack-v0.2.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "605fcfd142b2abf7ec32894cf97be831bf309159fe7af28897d1f13709d443b7"
    else
      url "https://github.com/pipe-rack/piperack/releases/download/v0.2.2/piperack-v0.2.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ae951ef6356c7f57c17e4f87413c1bd4e61d0ef54f9a1cec3e37559433e7705c"
    end
  end

  def install
    bin.install "piperack"
  end

  test do
    system "#{bin}/piperack", "--version"
  end
end
