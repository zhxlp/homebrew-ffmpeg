class Frotz < Formula
  desc "Infocom-style interactive fiction player"
  homepage "https://github.com/DavidGriffith/frotz"
  url "https://github.com/DavidGriffith/frotz/archive/2.44.tar.gz"
  sha256 "dbb5eb3bc95275dcb984c4bdbaea58bc1f1b085b20092ce6e86d9f0bf3ba858f"
  head "https://github.com/DavidGriffith/frotz.git"



  def install
    inreplace "Makefile" do |s|
      s.remove_make_var! %w[CC OPTS]
      s.change_make_var! "PREFIX", prefix
      s.change_make_var! "CONFIG_DIR", etc
      s.change_make_var! "MAN_PREFIX", share
    end

    system "make", "frotz"
    system "make", "install"
  end
end
