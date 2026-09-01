class Katamari < Formula
  desc "Terminal diff-review tool with LSP — hover, go-to-definition, references and diagnostics inside a git/jj diff"
  homepage "https://github.com/isamisushi/katamari"
  version "0.11.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/isamisushi/katamari/releases/download/v0.11.0/katamari-aarch64-apple-darwin.tar.xz"
      sha256 "c3769595e1162acdb718b325439d287d3c8d0768e4dce2c309d0700eeab9a94f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/isamisushi/katamari/releases/download/v0.11.0/katamari-x86_64-apple-darwin.tar.xz"
      sha256 "c1f8887a27c86e77ad3fd40d63eae5d1ba34e3eeb9c143eaab7e47a0748f76ae"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/isamisushi/katamari/releases/download/v0.11.0/katamari-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "bc5b54956996ebbc01ca1c590d0e1f1fc428d5436cfaefe6e5e509be4694e3d2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/isamisushi/katamari/releases/download/v0.11.0/katamari-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "387335f8af1af24e4adeb37a159f33c2fc6563afb9dfeab0e8082bf6f7acfa97"
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
