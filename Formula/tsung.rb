class Tsung < Formula
  desc "Load testing for HTTP, PostgreSQL, Jabber, and others"
  homepage "http://tsung.erlang-projects.org/"
  url "http://tsung.erlang-projects.org/dist/tsung-1.7.0.tar.gz"
  sha256 "6394445860ef34faedf8c46da95a3cb206bc17301145bc920151107ffa2ce52a"
  head "https://github.com/processone/tsung.git"



  depends_on "erlang"
  depends_on "gnuplot"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    ENV.deparallelize
    system "make", "install"
  end

  test do
    system bin/"tsung", "status"
  end
end
