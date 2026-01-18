class Piperack < Formula
  desc "Concurrent command runner for developers who value their time"
  homepage "https://github.com/pipe-rack/piperack"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/pipe-rack/piperack/releases/download/v0.1.0/piperack-v0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "<sha256-macos-arm64>"
    else
      url "https://github.com/pipe-rack/piperack/releases/download/v0.1.0/piperack-v0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "<sha256-macos-x86_64>"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/pipe-rack/piperack/releases/download/v0.1.0/piperack-v0.1.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "<sha256-linux-arm64>"
    else
      url "https://github.com/pipe-rack/piperack/releases/download/v0.1.0/piperack-v0.1.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "<sha256-linux-x86_64>"
    end
  end

  def install
    bin.install "piperack"
  end

  test do
    system "#{bin}/piperack", "--version"
  end
end
