class Piperack < Formula
  desc "Concurrent command runner for developers who value their time"
  homepage "https://github.com/pipe-rack/piperack"
  version "0.2.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/pipe-rack/piperack/releases/download/v0.2.1/piperack-v0.2.1-aarch64-apple-darwin.tar.gz"
      sha256 "1463ee5e4470a1d27ff2b11ec3c1f51f74c0f704616033cf75646bc67c323244"
    else
      url "https://github.com/pipe-rack/piperack/releases/download/v0.2.1/piperack-v0.2.1-x86_64-apple-darwin.tar.gz"
      sha256 "802fee18c2c5b796acc614c4e9220f75ffb4fd5e314d1f228d81bf089c773a75"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/pipe-rack/piperack/releases/download/v0.2.1/piperack-v0.2.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "50f9264904ba7886c4be45be07a681136697866173339d1be8360d0235e6b4be"
    else
      url "https://github.com/pipe-rack/piperack/releases/download/v0.2.1/piperack-v0.2.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7508432b4c965724e1136cc386d0efeb6ee00fd8a58e8662999cae815408ca9f"
    end
  end

  def install
    bin.install "piperack"
  end

  test do
    system "#{bin}/piperack", "--version"
  end
end
