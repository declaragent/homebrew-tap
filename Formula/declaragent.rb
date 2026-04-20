# frozen_string_literal: true

# Homebrew formula for `declaragent`.
#
# Seed template — placeholder tokens (wrapped in double curlies) are
# stamped by the release pipeline before the formula lands in the
# `declaragent/homebrew-tap` repo. See ../README.md for the promotion
# workflow.
#
# The formula serves both macOS arm64 (Apple Silicon) and macOS x64
# (Intel), falling back to the Linux build on Linuxbrew hosts. Every
# download URL points at the GitHub release tarballs produced by
# `.github/workflows/release-binaries.yml`.
class Declaragent < Formula
  desc "Declarative, git-versioned AI agent platform"
  homepage "https://declaragent.dev"
  version "0.1.4"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/declaragent/declaragent/releases/download/v#{version}/declaragent-darwin-arm64.tar.gz"
      sha256 "7c8c9bf4c43aa9a12f4ea1a0efdfbb3fbfcabb396862c251bd73adfc2f72b652"
    end
    on_intel do
      url "https://github.com/declaragent/declaragent/releases/download/v#{version}/declaragent-darwin-x64.tar.gz"
      sha256 "fc1b7b891c4975a419cec4f0ab3f9b349cfe0ac9c6d51db79aff2de39d54f0d2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/declaragent/declaragent/releases/download/v#{version}/declaragent-linux-arm64.tar.gz"
      sha256 "e7ecedbe1054965d726f29e27e5995a5981b919b80e75304100bab33d2c2190e"
    end
    on_intel do
      url "https://github.com/declaragent/declaragent/releases/download/v#{version}/declaragent-linux-x64.tar.gz"
      sha256 "e07c2c5f1ad3f8f77b5aa1c64b4ce2bfe67f8f18f0a241e7dfb303b57eb94e7c"
    end
  end

  def install
    bin.install "declaragent"
  end

  test do
    # Smoke check — `declaragent --help` must exit cleanly and print the
    # usage banner. A broken binary fails this stanza on every formula
    # audit pass (`brew audit`, `brew test-bot`) so it catches the most
    # common regression: a malformed single-executable bundle.
    assert_match "declaragent", shell_output("#{bin}/declaragent --help")
  end
end
