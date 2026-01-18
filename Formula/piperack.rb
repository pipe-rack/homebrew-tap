class Piperack < Formula
  desc "Concurrent command runner for developers who value their time"
  homepage "https://github.com/pipe-rack/piperack"
  version "0.1.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/pipe-rack/piperack/releases/download/v0.1.3/piperack-v0.1.3-aarch64-apple-darwin.tar.gz"
      sha256 "79934fd4ee5d524758304648ca3239f541890165361075047b7c9baded99222a"
    else
      url "https://github.com/pipe-rack/piperack/releases/download/v0.1.3/piperack-v0.1.3-x86_64-apple-darwin.tar.gz"
      sha256 "a62c1435015ceabdf8ceef7367fa1585e152565e0dbabf019f89179ac799926f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/pipe-rack/piperack/releases/download/v0.1.3/piperack-v0.1.3-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ff8a5f9888dc9868cfdc50d70796e14a3ec3b3a37fbe227baaec58e2d0c5025d"
    else
      url "https://github.com/pipe-rack/piperack/releases/download/v0.1.3/piperack-v0.1.3-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "35ab590b554f58a675b01bfbd4661de191599427dfbcc5d8f6c104da019ab1eb"
    end
  end

  def install
    bin.install "piperack"
  end

  test do
    system "#{bin}/piperack", "--version"
  end
end
