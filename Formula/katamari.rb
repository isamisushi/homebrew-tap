class Katamari < Formula
  desc "Terminal diff-review tool with LSP — hover, go-to-definition, references and diagnostics inside a git/jj diff"
  homepage "https://github.com/isamisushi/katamari"
  version "0.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/isamisushi/katamari/releases/download/v0.6.0/katamari-aarch64-apple-darwin.tar.xz"
      sha256 "2fe0e407f5b8b142a76f40f91eeb6eef8cce1dd8ecd549e1f2786fe88dc0eebf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/isamisushi/katamari/releases/download/v0.6.0/katamari-x86_64-apple-darwin.tar.xz"
      sha256 "e14091e54da1eec7cf0bd1c35ebdcccbe6d3d4719b5c5822030bf8a3f3e0a18f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/isamisushi/katamari/releases/download/v0.6.0/katamari-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "114bedaebb43f6551ec4eddc2b0332817752f448d5669e1ff59aacde06d47a5a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/isamisushi/katamari/releases/download/v0.6.0/katamari-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "343a182803585e250d41d1359fcd060ecfb84bb9d8f7071a724a5c7d973cb7d7"
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
