class Piperack < Formula
  desc "Concurrent command runner for developers who value their time"
  homepage "https://github.com/pipe-rack/piperack"
  version "0.2.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/pipe-rack/piperack/releases/download/v0.2.3/piperack-v0.2.3-aarch64-apple-darwin.tar.gz"
      sha256 "a621a9a1d91eafd77fd3afa8ebdc71602bfa049acf1b1b25c2d70294ef31c38c"
    else
      url "https://github.com/pipe-rack/piperack/releases/download/v0.2.3/piperack-v0.2.3-x86_64-apple-darwin.tar.gz"
      sha256 "5bcfd72df30102a8e5b243bfd2f6ac6b97872d52e6ed1faac04e10b323422b54"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/pipe-rack/piperack/releases/download/v0.2.3/piperack-v0.2.3-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7d35bf8a6730b1c0b5d731fa8116a34116fa7aa9deeeae7033265d7224c81c0f"
    else
      url "https://github.com/pipe-rack/piperack/releases/download/v0.2.3/piperack-v0.2.3-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c2c599b73e21b49d2e4932c8cc7fb4025bcfdcb990924d5c748c3ab336416371"
    end
  end

  def install
    bin.install "piperack"
  end

  test do
    system "#{bin}/piperack", "--version"
  end
end
