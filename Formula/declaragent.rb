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
  version "0.1.3"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/declaragent/declaragent/releases/download/v#{version}/declaragent-darwin-arm64.tar.gz"
      sha256 "ad56216c28b3f5d168f33dad63424e7f3133300f0e3672e93e068df908baa85d"
    end
    on_intel do
      url "https://github.com/declaragent/declaragent/releases/download/v#{version}/declaragent-darwin-x64.tar.gz"
      sha256 "020a7e99e85d176e2b35b72936b4c249758bd2b3e12997e131d1a521585799e1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/declaragent/declaragent/releases/download/v#{version}/declaragent-linux-arm64.tar.gz"
      sha256 "eb4fc7617296d5bcc40797f33e6eb840906969fbd1835618274fb2680eb45d97"
    end
    on_intel do
      url "https://github.com/declaragent/declaragent/releases/download/v#{version}/declaragent-linux-x64.tar.gz"
      sha256 "a1b49005025af997605da4e5335abcd99f582ed80abe47fe347c70720471c5fd"
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
