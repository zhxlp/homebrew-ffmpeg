class Daq < Formula
  desc "Network intrusion prevention and detection system"
  homepage "https://www.snort.org/"
  url "https://www.mirrorservice.org/sites/distfiles.macports.org/daq/daq-2.0.6.tar.gz"
  mirror "https://fossies.org/linux/misc/daq-2.0.6.tar.gz"
  sha256 "b40e1d1273e08aaeaa86e69d4f28d535b7e53bdb3898adf539266b63137be7cb"



  # libpcap on >= 10.12 has pcap_lib_version() instead of pcap_version
  # Reported 8 Oct 2017 to bugs AT snort DOT org
  if MacOS.version >= :sierra
    patch do
      url "https://raw.githubusercontent.com/Homebrew/formula-patches/b345dac/daq/patch-pcap-version.diff"
      sha256 "20d2bf6aec29824e2b7550f32251251cdc9d7aac3a0861e81a68cd0d1e513bf3"
    end
  end

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <daq.h>
      #include <stdio.h>

      int main()
      {
        DAQ_Module_Info_t* list;
        int size = daq_get_module_list(&list);
        daq_free_module_list(list, size);
        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-L#{lib}", "-ldaq", "-o", "test"
    system "./test"
  end
end
