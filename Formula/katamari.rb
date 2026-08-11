class Katamari < Formula
  desc "Terminal diff-review tool with LSP — hover, go-to-definition, references and diagnostics inside a git/jj diff"
  homepage "https://github.com/isamisushi/katamari"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/isamisushi/katamari/releases/download/v0.5.0/katamari-aarch64-apple-darwin.tar.xz"
      sha256 "d823818df0992294277b5a4ec9827a655f9103ac62581625e07931f4c4d1feb1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/isamisushi/katamari/releases/download/v0.5.0/katamari-x86_64-apple-darwin.tar.xz"
      sha256 "4a3014c86a93cff6728075017426cea92c9ff2ef5cfae7103f932a3874fea137"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/isamisushi/katamari/releases/download/v0.5.0/katamari-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f7b4453b11af76bc757e53c2946986eef486454c42f33e1538934822af8494a8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/isamisushi/katamari/releases/download/v0.5.0/katamari-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a4215223cc3ba3dbef92233453394aeed81bfae09b3122e06d1080e62bedf59d"
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
