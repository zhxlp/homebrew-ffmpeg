class GitImerge < Formula
  desc "Incremental merge for git"
  homepage "https://github.com/mhagger/git-imerge"
  url "https://github.com/mhagger/git-imerge/archive/v1.1.0.tar.gz"
  sha256 "62692f43591cc7d861689c60b68c55d7b10c7a201c1026096a7efc771df2ca28"
  head "https://github.com/mhagger/git-imerge.git"



  def install
    bin.mkpath
    # Work around Makefile insisting to write to $(DESTDIR)/etc/bash_completion.d
    system "make", "install", "DESTDIR=#{prefix}", "PREFIX="
  end

  test do
    system bin/"git-imerge", "-h"
  end
end
