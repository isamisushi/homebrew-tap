class Katamari < Formula
  desc "Terminal diff-review tool with LSP — hover, go-to-definition, references and diagnostics inside a git/jj diff"
  homepage "https://github.com/isamisushi/katamari"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/isamisushi/katamari/releases/download/v0.4.0/katamari-aarch64-apple-darwin.tar.xz"
      sha256 "59269ad56dae5d8a1c84c8af9081226657dcef278b64356b6631a0f595ee196b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/isamisushi/katamari/releases/download/v0.4.0/katamari-x86_64-apple-darwin.tar.xz"
      sha256 "7cf858050a0449d57f8eede5fdfbe74842053fb4da380dc22e26c1e0b1a6d5e4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/isamisushi/katamari/releases/download/v0.4.0/katamari-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c0abce13a6f6b7cbf5dc8c9b5ebed2c370df35fc77797a5abe0e29a77ff27ae0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/isamisushi/katamari/releases/download/v0.4.0/katamari-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "fdb7ace175c37cb39df89f8f9a95c234be0a2bb8fe1b01f4769d1bede741ad05"
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
