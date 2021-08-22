class Logtalk < Formula
  desc "Object-oriented logic programming language"
  homepage "https://logtalk.org/"
  url "https://github.com/LogtalkDotOrg/logtalk3/archive/lgt3230stable.tar.gz"
  version "3.23.0"
  sha256 "0ea042bcc323d9ef688522698216db4bf3814c435689dfc8b3b00220184504a4"



  depends_on "gnu-prolog"

  def install
    cd("scripts") { system "./install.sh", "-p", prefix }
  end
end
