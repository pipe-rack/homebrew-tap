class Piperack < Formula
  desc "Concurrent command runner for developers who value their time"
  homepage "https://github.com/pipe-rack/piperack"
  version "0.2.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/pipe-rack/piperack/releases/download/v0.2.4/piperack-v0.2.4-aarch64-apple-darwin.tar.gz"
      sha256 "4af3c362e3773dd0d9d7f5b4437ab88ea6a82c3498c1e392ea34f51a0e082581"
    else
      url "https://github.com/pipe-rack/piperack/releases/download/v0.2.4/piperack-v0.2.4-x86_64-apple-darwin.tar.gz"
      sha256 "d197bb5ef7050a38ab5809a6f3075bcc7d38d43feeff1c7f3858913f14a003da"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/pipe-rack/piperack/releases/download/v0.2.4/piperack-v0.2.4-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b7b9db032fab63193fa1d3005b0caea1a16993f6d8bc1730529be03be085955f"
    else
      url "https://github.com/pipe-rack/piperack/releases/download/v0.2.4/piperack-v0.2.4-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "cfbde636376c3835a66b26d49b0e1fbe8bc0bb9d9be3524b1445394622d7b687"
    end
  end

  def install
    bin.install "piperack"
  end

  test do
    system "#{bin}/piperack", "--version"
  end
end
