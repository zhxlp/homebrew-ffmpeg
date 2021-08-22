class Gist < Formula
  desc "Command-line utility for uploading Gists"
  homepage "https://github.com/defunkt/gist"
  url "https://github.com/defunkt/gist/archive/v5.0.0.tar.gz"
  sha256 "28a3ebaad90ede9a59bd4dbe4850a07cc6e3294a92849a0f0b17ebf6a17ea33b"
  head "https://github.com/defunkt/gist.git"



  depends_on "ruby" if MacOS.version <= :sierra

  def install
    system "rake", "install", "prefix=#{prefix}"
  end

  test do
    output = pipe_output("#{bin}/gist", "homebrew")
    assert_match "Github now requires credentials", output
  end
end
