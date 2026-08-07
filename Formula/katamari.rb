class Katamari < Formula
  desc "Terminal diff-review tool with LSP — hover, go-to-definition, references and diagnostics inside a git/jj diff"
  homepage "https://github.com/isamisushi/katamari"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/isamisushi/katamari/releases/download/v0.3.0/katamari-aarch64-apple-darwin.tar.xz"
      sha256 "c8703fab3dc540cd304b0bbcebd3f45c25451ac4edb609c4682170a853f23f34"
    end
    if Hardware::CPU.intel?
      url "https://github.com/isamisushi/katamari/releases/download/v0.3.0/katamari-x86_64-apple-darwin.tar.xz"
      sha256 "2d89cd2803e1b2456d84e26138f76ef7d32448114495a59a7cb1922794f48541"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/isamisushi/katamari/releases/download/v0.3.0/katamari-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "fd7b2b6f43935cd35fed391179c5c59396d5f07f2f0023a8d838d20c785aae2f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/isamisushi/katamari/releases/download/v0.3.0/katamari-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7f1f11241c7178d30439a666b8563b7209ef7af280b78015aa44bdbb74b08a4e"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "katamari", "ktmr" if OS.mac? && Hardware::CPU.arm?
    bin.install "katamari", "ktmr" if OS.mac? && Hardware::CPU.intel?
    bin.install "katamari", "ktmr" if OS.linux? && Hardware::CPU.arm?
    bin.install "katamari", "ktmr" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
