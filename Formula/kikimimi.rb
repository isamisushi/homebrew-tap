class Kikimimi < Formula
  desc "Observability for AI coding agents - see what your agents actually do, locally first"
  homepage "https://github.com/isamisushi/kikimimi"
  version "0.7.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/isamisushi/kikimimi/releases/download/v0.7.0/kikimimi-aarch64-apple-darwin.tar.xz"
      sha256 "688f607389f7aa1dc0d65fac2226fd476b998828d634293998a49bee91f3e061"
    end
    if Hardware::CPU.intel?
      url "https://github.com/isamisushi/kikimimi/releases/download/v0.7.0/kikimimi-x86_64-apple-darwin.tar.xz"
      sha256 "fea3d8978d4fad952462df0d81a0d4e30db51f7278e23cf4aaad0fffb4cf43bf"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/isamisushi/kikimimi/releases/download/v0.7.0/kikimimi-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e0106d7a7d5ab6c2081ab6c37f9d806c1f4587a45d1894c002ada606b52d08be"
    end
    if Hardware::CPU.intel?
      url "https://github.com/isamisushi/kikimimi/releases/download/v0.7.0/kikimimi-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "31541e737fc2f1134ba267cde08c3149cbb55b81d4ad8001328fbb0c1cc09541"
    end
  end
  license "Apache-2.0"

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
      bin.install "kikimimi", "kkmm"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "kikimimi", "kkmm"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "kikimimi", "kkmm"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "kikimimi", "kkmm"
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
