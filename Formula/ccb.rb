class Ccb < Formula
  desc "Bookmark good prompts from your Claude Code session history"
  homepage "https://github.com/yuto1009/homebrew-ccb"
  url "https://github.com/yuto1009/homebrew-ccb/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "22a715f29027666b464d1f92050be0cd1449d2770a5b47ae8b236d83983090c9"
  license "MIT"
  head "https://github.com/yuto1009/homebrew-ccb.git", branch: "main"

  def install
    bin.install "ccb"
  end

  test do
    assert_match "ccb", shell_output("#{bin}/ccb --version")
  end
end
