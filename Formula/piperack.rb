class Piperack < Formula
  desc "Concurrent command runner for developers who value their time"
  homepage "https://github.com/pipe-rack/piperack"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/pipe-rack/piperack/releases/download/v0.2.0/piperack-v0.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "09cb7e86a1e2aff6076d5cff631ed4ebc7ce2d50152abff18d25c28ac1a588f7"
    else
      url "https://github.com/pipe-rack/piperack/releases/download/v0.2.0/piperack-v0.2.0-x86_64-apple-darwin.tar.gz"
      sha256 "ceb39583afa0b37aaa6d945e58cc84ec3a9c0f1c0baba6435fca867d2dfc6984"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/pipe-rack/piperack/releases/download/v0.2.0/piperack-v0.2.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f708f014139d495c6fb0de9216e9545a5d6dc6b61ab7b6c08605c085b29e049d"
    else
      url "https://github.com/pipe-rack/piperack/releases/download/v0.2.0/piperack-v0.2.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "21b5331dde3083757f6e3d454e42d76e3971e80d8a47d0df85ff00c9c5f583b8"
    end
  end

  def install
    bin.install "piperack"
  end

  test do
    system "#{bin}/piperack", "--version"
  end
end
