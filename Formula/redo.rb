class Redo < Formula
  desc "Implements djb's redo: an alternative to make(1)"
  homepage "https://github.com/apenwarr/redo"
  url "https://github.com/apenwarr/redo/archive/redo-0.21.tar.gz"
  sha256 "79a077092bd8085d6bd98226960590e0fe04ada5a4e1ee6adee3856cf0167b25"



  resource "docs" do
    url "https://github.com/apenwarr/redo.git", :branch => "man"
  end

  def install
    ENV["PREFIX"] = prefix
    system "./redo", "install"
    rm share/"doc/redo/README.md" # lets not have two copies
    man1.install resource("docs")
  end

  test do
    system "#{bin}/redo", "--version"
  end
end
