class Procmail < Formula
  desc "Autonomous mail processor"
  homepage "https://web.archive.org/web/20151013184044/procmail.org/"
  # Note the use of the patched version from Apple
  url "https://opensource.apple.com/tarballs/procmail/procmail-14.tar.gz"
  sha256 "f3bd815d82bb70625f2ae135df65769c31dd94b320377f0067cd3c2eab968e81"



  def install
    system "make", "-C", "procmail", "BASENAME=#{prefix}", "MANDIR=#{man}",
           "LOCKINGTEST=1", "install"
  end

  test do
    path = testpath/"test.mail"
    path.write <<~EOS
      From alice@example.net Tue Sep 15 15:33:41 2015
      Date: Tue, 15 Sep 2015 15:33:41 +0200
      From: Alice <alice@example.net>
      To: Bob <bob@example.net>
      Subject: Test

      please ignore
    EOS
    assert_match /Subject: Test/, shell_output("#{bin}/formail -X 'Subject' < #{path}")
    assert_match /please ignore/, shell_output("#{bin}/formail -I '' < #{path}")
  end
end
