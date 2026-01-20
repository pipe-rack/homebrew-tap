class Piperack < Formula
  desc "Concurrent command runner for developers who value their time"
  homepage "https://github.com/pipe-rack/piperack"
  version "0.1.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/pipe-rack/piperack/releases/download/v0.1.4/piperack-v0.1.4-aarch64-apple-darwin.tar.gz"
      sha256 "1a5609907ea90cfb957fd33aeee97da0692b15ad8ef33d29bc1fddc5f772101b"
    else
      url "https://github.com/pipe-rack/piperack/releases/download/v0.1.4/piperack-v0.1.4-x86_64-apple-darwin.tar.gz"
      sha256 "9b0427a270e4e9ccfd9653a8080d10ac9014c1c6ebdf0e652b345d36ddeec48f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/pipe-rack/piperack/releases/download/v0.1.4/piperack-v0.1.4-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e6d016932b19182ce2fbcb25ba14f97f7746a906412fbef2780ed1bb822c2dbe"
    else
      url "https://github.com/pipe-rack/piperack/releases/download/v0.1.4/piperack-v0.1.4-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "36fcae6a14dea2d997525987e00e3f7f489c2b5898dd29574a3706b2d3ce6732"
    end
  end

  def install
    bin.install "piperack"
  end

  test do
    system "#{bin}/piperack", "--version"
  end
end
