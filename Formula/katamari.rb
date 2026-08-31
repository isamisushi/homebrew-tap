class Katamari < Formula
  desc "Terminal diff-review tool with LSP — hover, go-to-definition, references and diagnostics inside a git/jj diff"
  homepage "https://github.com/isamisushi/katamari"
  version "0.7.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/isamisushi/katamari/releases/download/v0.7.1/katamari-aarch64-apple-darwin.tar.xz"
      sha256 "e8ee55898923a9b19d579d0a78eb72baf4582494b89fb98541fc3d027bb807e4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/isamisushi/katamari/releases/download/v0.7.1/katamari-x86_64-apple-darwin.tar.xz"
      sha256 "8b8173c964932fa596f8abddbe9837607a469201b5d7a4ada053b5902907c2d2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/isamisushi/katamari/releases/download/v0.7.1/katamari-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f9d5d3482b046cdd03a438d43fa1a2c8a4313e709b5a2ba95722e3ca47079b27"
    end
    if Hardware::CPU.intel?
      url "https://github.com/isamisushi/katamari/releases/download/v0.7.1/katamari-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "32c50687143d961e6f8233eaf1b83238f72b89b7979b0c2e63ada1ed1d007403"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "katamari", "ktmr"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "katamari", "ktmr"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "katamari", "ktmr"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "katamari", "ktmr"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
