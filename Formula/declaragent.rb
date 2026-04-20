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
  version "0.1.7"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/declaragent/declaragent/releases/download/v#{version}/declaragent-darwin-arm64.tar.gz"
      sha256 "bb5010aab6fa8d092cd1e55f305f79c6abf433be4ea7e78fc4840953d4afab4d"
    end
    on_intel do
      url "https://github.com/declaragent/declaragent/releases/download/v#{version}/declaragent-darwin-x64.tar.gz"
      sha256 "9d1947c79c65efe08fb33c6519832ff65a27d6157a7584ab604496533f0cff74"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/declaragent/declaragent/releases/download/v#{version}/declaragent-linux-arm64.tar.gz"
      sha256 "2b2e2f8dc022417bd82e6f1e6e81896c2f798f10d8875474fbf7434c63f82765"
    end
    on_intel do
      url "https://github.com/declaragent/declaragent/releases/download/v#{version}/declaragent-linux-x64.tar.gz"
      sha256 "db76718d57392373cd754e47048a9deee8cafb4251ca6a59e76100d64f287387"
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
