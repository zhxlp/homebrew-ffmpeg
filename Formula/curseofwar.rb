class Curseofwar < Formula
  desc "Fast-paced action strategy game"
  homepage "https://a-nikolaev.github.io/curseofwar/"
  url "https://github.com/a-nikolaev/curseofwar/archive/v1.2.0.tar.gz"
  sha256 "91b7781e26341faa6b6999b6baf6e74ef532fa94303ab6a2bf9ff6d614a3f670"
  head "https://github.com/a-nikolaev/curseofwar.git"



  def install
    system "make"
    bin.install "curseofwar"
    man6.install "curseofwar.6"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/curseofwar -v", 1).chomp
  end
end
