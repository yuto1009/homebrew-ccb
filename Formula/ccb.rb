class Ccb < Formula
  desc "Bookmark good prompts from your Claude Code session history"
  homepage "https://github.com/yuto1009/homebrew-ccb"
  url "https://github.com/yuto1009/homebrew-ccb/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "8dd011707964b6c7754c51f37c37767c68fc9d97bd6ff9d63cb3dbd671fecfef"
  license "MIT"
  head "https://github.com/yuto1009/homebrew-ccb.git", branch: "main"

  def install
    bin.install "ccb"
  end

  test do
    assert_match "ccb", shell_output("#{bin}/ccb --version")
  end
end
