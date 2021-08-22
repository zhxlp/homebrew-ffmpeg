class Ganglia < Formula
  desc "Scalable distributed monitoring system"
  homepage "https://ganglia.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/ganglia/ganglia%20monitoring%20core/3.7.2/ganglia-3.7.2.tar.gz"
  sha256 "042dbcaf580a661b55ae4d9f9b3566230b2232169a0898e91a797a4c61888409"
  revision 3



  head do
    url "https://github.com/ganglia/monitor-core.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "pkg-config" => :build
  depends_on "apr"
  depends_on "confuse"
  depends_on "pcre"
  depends_on "rrdtool"

  conflicts_with "coreutils", :because => "both install `gstat` binaries"

  def install
    if build.head?
      inreplace "bootstrap", "libtoolize", "glibtoolize"
      inreplace "libmetrics/bootstrap", "libtoolize", "glibtoolize"
      system "./bootstrap"
    end

    inreplace "configure", 'varstatedir="/var/lib"', %Q(varstatedir="#{var}/lib")
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--sbindir=#{bin}",
                          "--sysconfdir=#{etc}",
                          "--mandir=#{man}",
                          "--with-gmetad",
                          "--with-libapr=#{Formula["apr"].opt_bin}/apr-1-config",
                          "--with-libpcre=#{Formula["pcre"].opt_prefix}"
    system "make", "install"

    # Generate the default config file
    system "#{bin}/gmond -t > #{etc}/gmond.conf" unless File.exist? "#{etc}/gmond.conf"
  end

  def post_install
    (var/"lib/ganglia/rrds").mkpath
  end

  def caveats; <<~EOS
    If you didn't have a default config file, one was created here:
      #{etc}/gmond.conf
  EOS
  end

  test do
    begin
      pid = fork do
        exec bin/"gmetad", "--pid-file=#{testpath}/pid"
      end
      sleep 2
      assert_predicate testpath/"pid", :exist?
    ensure
      Process.kill "TERM", pid
      Process.wait pid
    end
  end
end
