class Kikimimi < Formula
  desc "Observability for AI coding agents - see what your agents actually do, locally first"
  homepage "https://github.com/isamisushi/kikimimi"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/isamisushi/kikimimi/releases/download/v0.2.0/kikimimi-aarch64-apple-darwin.tar.xz"
      sha256 "1cd97ffe0cc0283e437289f0ac0f95458db416633fd69f824038c2e1df316f0e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/isamisushi/kikimimi/releases/download/v0.2.0/kikimimi-x86_64-apple-darwin.tar.xz"
      sha256 "a48b8d3f05353a02cccb5611988a96f44be1448044de0f89777e4141cf86e875"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/isamisushi/kikimimi/releases/download/v0.2.0/kikimimi-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e3873b9825b6a4bc037b36360f45e80fe1d0716cc16265c74f382dadd043dc59"
    end
    if Hardware::CPU.intel?
      url "https://github.com/isamisushi/kikimimi/releases/download/v0.2.0/kikimimi-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2afeff5fea4757dae1178f3b6824defe3a1eba21bf5a7b236bc715fe2ac34ef4"
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
