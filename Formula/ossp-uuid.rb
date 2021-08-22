class OsspUuid < Formula
  desc "ISO-C API and CLI for generating UUIDs"
  homepage "https://web.archive.org/web/www.ossp.org/pkg/lib/uuid/"
  url "https://mirrors.ocf.berkeley.edu/debian/pool/main/o/ossp-uuid/ossp-uuid_1.6.2.orig.tar.gz"
  mirror "https://mirrorservice.org/sites/ftp.debian.org/debian/pool/main/o/ossp-uuid/ossp-uuid_1.6.2.orig.tar.gz"
  sha256 "11a615225baa5f8bb686824423f50e4427acd3f70d394765bdff32801f0fd5b0"
  revision 2



  def install
    # upstream ticket: http://cvs.ossp.org/tktview?tn=200
    # pkg-config --cflags uuid returns the wrong directory since we override the
    # default, but uuid.pc.in does not use it
    inreplace "uuid.pc.in" do |s|
      s.gsub! /^(exec_prefix)=\$\{prefix\}$/, '\1=@\1@'
      s.gsub! %r{^(includedir)=\$\{prefix\}/include$}, '\1=@\1@'
      s.gsub! %r{^(libdir)=\$\{exec_prefix\}/lib$}, '\1=@\1@'
    end

    system "./configure", "--prefix=#{prefix}",
                          "--includedir=#{include}/ossp",
                          "--without-perl",
                          "--without-php",
                          "--without-pgsql"
    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/uuid-config", "--version"
  end
end
