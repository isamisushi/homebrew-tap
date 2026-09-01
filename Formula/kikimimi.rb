class Kikimimi < Formula
  desc "Observability for AI coding agents - see what your agents actually do, locally first"
  homepage "https://github.com/isamisushi/kikimimi"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/isamisushi/kikimimi/releases/download/v0.3.0/kikimimi-aarch64-apple-darwin.tar.xz"
      sha256 "2546b8029373d83da2554de93b39cc1399e54504e2333c0b3d4d7b79168c9092"
    end
    if Hardware::CPU.intel?
      url "https://github.com/isamisushi/kikimimi/releases/download/v0.3.0/kikimimi-x86_64-apple-darwin.tar.xz"
      sha256 "1c46cfab975f8398621d729db938332e836801eabcdcd2013d0e3bad615a663e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/isamisushi/kikimimi/releases/download/v0.3.0/kikimimi-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3d2c6da8a4f8640f5a925fd9406c7e5970bcbe79ef0d89ab4b5005187e1463b7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/isamisushi/kikimimi/releases/download/v0.3.0/kikimimi-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b0ecf6a185a221bac3796e32b770834aab6dccd6b9878fecf1e50628291efd66"
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
