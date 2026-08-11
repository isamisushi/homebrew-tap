class Katamari < Formula
  desc "Terminal diff-review tool with LSP — hover, go-to-definition, references and diagnostics inside a git/jj diff"
  homepage "https://github.com/isamisushi/katamari"
  version "0.5.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/isamisushi/katamari/releases/download/v0.5.1/katamari-aarch64-apple-darwin.tar.xz"
      sha256 "d1d6faa5d7976113c28d9a4b56246d73e88c01673678b0aca98940b3041b5163"
    end
    if Hardware::CPU.intel?
      url "https://github.com/isamisushi/katamari/releases/download/v0.5.1/katamari-x86_64-apple-darwin.tar.xz"
      sha256 "18de0b3e43b2db73de28633e69fe4b25ac88d1cb41a0530eee3d4f56e9a0b17f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/isamisushi/katamari/releases/download/v0.5.1/katamari-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6ef44da7f1cd3534d33cf6906da5ba360509aa29f76485a65d26cc0dcf6f7dc0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/isamisushi/katamari/releases/download/v0.5.1/katamari-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "144da0602113123c7eb93f05bc7ddacac2bbb63dc509ace870dc27271faed98a"
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
