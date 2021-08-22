class Eventql < Formula
  desc "Database for large-scale event analytics"
  homepage "https://eventql.io"
  url "https://github.com/eventql/eventql/releases/download/v0.4.1/eventql-0.4.1.tgz"
  sha256 "a61f093bc45a1f9b9b374331ab40665c0c1060a2278b2833c0b6eb6c547b4ef4"



  head do
    url "https://github.com/eventql/eventql.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  def install
    # the internal libzookeeper fails to build if we don't deparallelize
    # https://github.com/eventql/eventql/issues/180
    ENV.deparallelize
    system "./autogen.sh" if build.head?
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    begin
      pid = fork do
        exec bin/"evqld", "--standalone", "--datadir", testpath
      end
      sleep 1
      system bin/"evql", "--database", "test", "-e", "SELECT 42;"
    ensure
      Process.kill "SIGTERM", pid
      Process.wait pid
    end
  end
end
