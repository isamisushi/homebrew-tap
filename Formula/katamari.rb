class Katamari < Formula
  desc "Terminal diff-review tool with LSP — hover, go-to-definition, references and diagnostics inside a git/jj diff"
  homepage "https://github.com/isamisushi/katamari"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/isamisushi/katamari/releases/download/v0.2.0/katamari-aarch64-apple-darwin.tar.xz"
      sha256 "34fc3f9b10c6de72ff750f0130c078dc1799c2dca0e73d87ed7df042ffd3bc4b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/isamisushi/katamari/releases/download/v0.2.0/katamari-x86_64-apple-darwin.tar.xz"
      sha256 "dfd556e46b43478c445c34f66ab4ff36ebb55c5d9ecfb47811845f8f453871d6"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/isamisushi/katamari/releases/download/v0.2.0/katamari-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0f62e3e149be39edf3866444c643e98a474c55d3c85ced4be2439a8d379ce3a5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/isamisushi/katamari/releases/download/v0.2.0/katamari-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "cf5b1d5c5113a6eac548794605e7a91c19f91a6f8ba4b26cf4f5249fc3ee84a1"
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
