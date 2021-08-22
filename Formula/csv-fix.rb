class CsvFix < Formula
  desc "Tool for manipulating CSV data"
  homepage "https://neilb.bitbucket.io/csvfix/"
  url "https://bitbucket.org/neilb/csvfix/get/version-1.6.tar.gz"
  sha256 "32982aa0daa933140e1ea5a667fb71d8adc731cc96068de3a8e83815be62c52b"



  def install
    # clang on Mt. Lion will try to build against libstdc++,
    # despite -std=gnu++0x
    ENV.libcxx

    system "make", "lin"
    bin.install "csvfix/bin/csvfix"
  end

  test do
    assert_equal '"foo","bar"',
                 pipe_output("#{bin}/csvfix trim", "foo , bar \n").chomp
  end
end
