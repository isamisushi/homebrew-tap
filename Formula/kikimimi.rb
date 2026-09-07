class Kikimimi < Formula
  desc "Observability for AI coding agents - see what your agents actually do, locally first"
  homepage "https://github.com/isamisushi/kikimimi"
  version "0.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/isamisushi/kikimimi/releases/download/v0.6.0/kikimimi-aarch64-apple-darwin.tar.xz"
      sha256 "bf91e9292e91c03e787bd0e51d3a7d46e48a6ed1657c5ca7849eb4a376ec7c0f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/isamisushi/kikimimi/releases/download/v0.6.0/kikimimi-x86_64-apple-darwin.tar.xz"
      sha256 "afdc1c7a1aca1b4d50aaf6bbcee010cb47388d12cc31432e857e8f5e535add32"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/isamisushi/kikimimi/releases/download/v0.6.0/kikimimi-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7f15d83c1c2b0f17ea95b99ef1ba67bdb2ad9b33884e5b10ddb2249083204a5a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/isamisushi/kikimimi/releases/download/v0.6.0/kikimimi-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "852a07ebb41f1a8232571b987aa591c1ffcd0ad1715ad7a94bfb3fa8fbfe6d1c"
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
