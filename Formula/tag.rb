class Tag < Formula
  desc "Manipulate and query tags on Mavericks files"
  homepage "https://github.com/jdberry/tag/"
  url "https://github.com/jdberry/tag/archive/v0.9.tar.gz"
  sha256 "ec2e3df36e18d4bd17f8fea34c1c5b9311e23d220e4ad64fc55505aa4c4b552a"
  head "https://github.com/jdberry/tag.git"



  def install
    system "make"
    bin.install "bin/tag"
  end

  test do
    test_tag = "test_tag"
    test_file = Pathname.pwd+"test_file"
    touch test_file
    system "#{bin}/tag", "--add", test_tag, test_file
    assert_equal test_tag, `#{bin}/tag --list --no-name #{test_file}`.chomp
  end
end
