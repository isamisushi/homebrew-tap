class Kikimimi < Formula
  desc "Observability for AI coding agents - see what your agents actually do, locally first"
  homepage "https://github.com/isamisushi/kikimimi"
  version "0.7.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/isamisushi/kikimimi/releases/download/v0.7.1/kikimimi-aarch64-apple-darwin.tar.xz"
      sha256 "9b41cadcbf07891649b3cf89af10967cd597068c837ea50a8a453c83bc003483"
    end
    if Hardware::CPU.intel?
      url "https://github.com/isamisushi/kikimimi/releases/download/v0.7.1/kikimimi-x86_64-apple-darwin.tar.xz"
      sha256 "a388ee391a681f64fa23937e12f7651a4c4ffd8479d5a9d7974153a38d94a20d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/isamisushi/kikimimi/releases/download/v0.7.1/kikimimi-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "354726a717d3bd7d2edbcec6fa4d5d889a9fb73079a6560d353030395528ddb1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/isamisushi/kikimimi/releases/download/v0.7.1/kikimimi-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "89d1bd19d30f16b86301082aa5d2e395a9b1f5c4d3b190c5613bb899b1e8c4ee"
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
