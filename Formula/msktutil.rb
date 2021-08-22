class Msktutil < Formula
  desc "Active Directory keytab management"
  homepage "https://sourceforge.net/projects/msktutil/"
  url "https://downloads.sourceforge.net/project/msktutil/msktutil-1.0.tar.bz2"
  sha256 "6e59d4bf41b8c75d573037c19ed29567a55f67ae5fe8c81e037b4f8c7327b642"



  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}"
    system "make", "install"
  end

  test do
    assert_match version.to_s, shell_output("#{sbin}/msktutil --version")
  end
end
