class Pound < Formula
  desc "Reverse proxy, load balancer and HTTPS front-end for web servers"
  homepage "http://www.apsis.ch/pound"
  url "http://www.apsis.ch/pound/Pound-2.8.tgz"
  sha256 "a7fd8690de0fd390615e79fd0f4bfd56a544b8ef97dd6659c07ecd3207480c25"



  depends_on "gperftools"
  depends_on "openssl"
  depends_on "pcre"

  def install
    system "./configure", "--prefix=#{prefix}", "--disable-tcmalloc"
    system "make"
    # Manual install to get around group issues
    sbin.install "pound", "poundctl"
    man8.install "pound.8", "poundctl.8"
  end

  test do
    (testpath/"pound.cfg").write <<~EOS
      ListenHTTP
        Address 1.2.3.4
        Port    80
        Service
          HeadRequire "Host: .*www.server0.com.*"
          BackEnd
            Address 192.168.0.10
            Port    80
          End
        End
      End
    EOS

    system "#{sbin}/pound", "-f", "#{testpath}/pound.cfg", "-c"
  end
end
