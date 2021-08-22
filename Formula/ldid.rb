class Ldid < Formula
  desc "Lets you manipulate the signature block in a Mach-O binary"
  homepage "https://cydia.saurik.com/info/ldid/"
  url "https://git.saurik.com/ldid.git",
      :tag      => "v1.2.1",
      :revision => "e4b7adc1e02c9f0e16cc9ae2841192b386f6d4ea"
  head "https://git.saurik.com/ldid.git"



  depends_on "openssl"

  def install
    inreplace "make.sh" do |s|
      s.gsub! %r{^.*/Applications/Xcode-5.1.1.app.*}, ""

      # Reported upstream 2 Sep 2018 (to saurik via email)
      s.gsub! "-mmacosx-version-min=10.4", "-mmacosx-version-min=#{MacOS.version}"
      s.gsub! "for arch in i386 x86_64; do", "for arch in x86_64; do" if MacOS.version >= :mojave
    end
    system "./make.sh"
    bin.install "ldid"
  end

  test do
    (testpath/"test.c").write <<~EOS
      int main(int argc, char **argv) { return 0; }
    EOS

    system ENV.cc, "test.c", "-o", "test"
    system bin/"ldid", "-S", "test"
  end
end
