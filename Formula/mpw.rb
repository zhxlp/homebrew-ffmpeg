class Mpw < Formula
  desc "Stateless/deterministic password and identity manager"
  homepage "https://masterpasswordapp.com/"
  url "https://masterpasswordapp.com/mpw-2.6-cli-5-0-g344771db.tar.gz"
  version "2.6-cli-5"
  sha256 "954c07b1713ecc2b30a07bead9c11e6204dd774ca67b5bdf7d2d6ad1c4eec170"
  revision 1
  head "https://github.com/Lyndir/MasterPassword.git"



  depends_on "json-c"
  depends_on "libsodium"
  depends_on "ncurses"

  def install
    cd "platform-independent/cli-c" if build.head?

    ENV["targets"] = "mpw"
    ENV["mpw_json"] = "1"
    ENV["mpw_color"] = "1"

    system "./build"
    system "./mpw-cli-tests"
    bin.install "mpw"
  end

  test do
    assert_equal "Jejr5[RepuSosp",
      shell_output("#{bin}/mpw -q -Fnone -u 'Robert Lee Mitchell' -M 'banana colored duckling' -tlong -c1 -a3 'masterpasswordapp.com'").strip
  end
end
