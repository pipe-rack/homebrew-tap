class Piperack < Formula
  desc "Concurrent command runner for developers who value their time"
  homepage "https://github.com/pipe-rack/piperack"
  version "0.1.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/pipe-rack/piperack/releases/download/v0.1.4/piperack-v0.1.4-aarch64-apple-darwin.tar.gz"
      sha256 "36ebdd053f14bc5e5a4bdaf949c59165acc87f1e5e6e4eb58a6d281a41f93ae5"
    else
      url "https://github.com/pipe-rack/piperack/releases/download/v0.1.4/piperack-v0.1.4-x86_64-apple-darwin.tar.gz"
      sha256 "a7a78a10a1971962e8cd7e0636ac6940030ffb56ac93047faa85f6bbe5b27c81"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/pipe-rack/piperack/releases/download/v0.1.4/piperack-v0.1.4-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6ee8c62ff8152258736fa79301c4ddcf91c9168f4807902a9330ebe20ff1a9d2"
    else
      url "https://github.com/pipe-rack/piperack/releases/download/v0.1.4/piperack-v0.1.4-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b957dd41dad55c72a44e6f81c1aa484eff8408ce458cb11fbcad4aef685152ad"
    end
  end

  def install
    bin.install "piperack"
  end

  test do
    system "#{bin}/piperack", "--version"
  end
end
