class Trafshow < Formula
  desc "Continuous network traffic display"
  # Upstream homepage down since late 2014, but only displays a manpage.
  homepage "https://web.archive.org/web/20130707021442/soft.risp.ru/trafshow/index_en.shtml"
  url "https://pkg.freebsd.org/ports-distfiles/trafshow-5.2.3.tgz"
  mirror "https://dl.bintray.com/homebrew/mirror/trafshow-5.2.3.tgz"
  sha256 "ea7e22674a66afcc7174779d0f803c1f25b42271973b4f75fab293b8d7db11fc"
  revision 1



  depends_on "libtool" => :build

  {
    "domain_resolver.c" => "43b97d4ea025ed2087e4525a0b1acffc887082148df6dd2603b91fa70f79b678",
    "colormask.c"       => "04121b295d22a18aaf078611c75401a620570fbd89362bba2dd1abc042ea3c4a",
    "trafshow.c"        => "3164a612689d8ec310453a50fbb728f9bae3c356b88c41b6eab7ba7e925b1bf1",
    "trafshow.1"        => "8072e52acc56dd6f64c75f5d2e8a814431404b3fdfbc15149aaad1d469c47ff1",
    "configure"         => "c6e34dddd6c159cbd373b2b593f7643642cb10449c6bc6c606e160586bc5b794",
  }.each do |name, sha|
    patch :p0 do
      url "https://raw.githubusercontent.com/Homebrew/formula-patches/be6fd4a/trafshow/patch-#{name}"
      sha256 sha
    end
  end

  # libpcap on 10.12 has pcap_lib_version() instead of pcap_version
  if MacOS.version >= :sierra
    patch :p0 do
      url "https://raw.githubusercontent.com/Homebrew/formula-patches/7ad7c77/trafshow/patch-pcap-version-sierra.diff"
      sha256 "03213c8b8b46241ecef8f427cdbec9b09f5fdc35b9d67672ad4b370a1186aed5"
    end
  end

  def install
    cp Dir["#{Formula["libtool"].opt_pkgshare}/*/config.{guess,sub}"], buildpath

    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--disable-slang"
    system "make"
    bin.install "trafshow"
    man1.install "trafshow.1"
    etc.install ".trafshow" => "trafshow.default"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/trafshow -v 2>&1", 1)
  end
end
