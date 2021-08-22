class Envchain < Formula
  desc "Secure your credentials in environment variables"
  homepage "https://github.com/sorah/envchain"
  url "https://github.com/sorah/envchain/archive/v1.0.1.tar.gz"
  sha256 "09af1fe1cfba3719418f90d59c29c081e1f22b38249f0110305b657bd306e9ae"
  head "https://github.com/sorah/envchain.git"



  def install
    system "make", "DESTDIR=#{prefix}", "install"
  end

  test do
    assert_match /envchain version #{version}/, shell_output("#{bin}/envchain 2>&1", 2)
  end
end
