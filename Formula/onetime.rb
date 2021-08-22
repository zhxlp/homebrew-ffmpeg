class Onetime < Formula
  desc "Encryption with one-time pads"
  homepage "https://www.red-bean.com/onetime/"
  url "https://www.red-bean.com/onetime/onetime-1.81.tar.gz"
  sha256 "36a83a83ac9f4018278bf48e868af00f3326b853229fae7e43b38d167e628348"
  revision 1



  # Fixes the Makefile to permit destination specification
  # https://github.com/kfogel/OneTime/pull/12
  patch do
    url "https://github.com/kfogel/OneTime/commit/61e534e2.patch?full_index=1"
    sha256 "b74d1769e8719f06755c7c3c4ac759063b31d9d0554b64c5fb600c7edf5cc5ea"
  end

  # Follow up to PR12 to fix my clumsiness in a variable call.
  patch do
    url "https://github.com/kfogel/OneTime/commit/fb0a12f2.patch?full_index=1"
    sha256 "11417d66886630f7a3c527f63227a75a39aee18029e60de99d7cb68ebe7769f5"
  end

  def install
    system "make", "prefix=#{prefix}", "install"
    inreplace bin/"onetime", %r{^#!/usr/bin/env python$}, "#!/usr/bin/python"
  end

  test do
    system "dd", "if=/dev/random", "of=pad_data.txt", "bs=1024", "count=1"
    (testpath/"input.txt").write "INPUT"
    system bin/"onetime", "-e", "--pad=pad_data.txt", "--no-trace",
                          "--config=.", "input.txt"
    system bin/"onetime", "-d", "--pad=pad_data.txt", "--no-trace",
                          "--config=.", "input.txt.onetime"
  end
end
