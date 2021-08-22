class Mobiledevice < Formula
  desc "CLI for Apple's Private (Closed) Mobile Device Framework"
  homepage "https://github.com/imkira/mobiledevice"
  url "https://github.com/imkira/mobiledevice/archive/v2.0.0.tar.gz"
  sha256 "07b167f6103175c5eba726fd590266bf6461b18244d34ef6d05a51fc4871e424"



  # Upstream is pretty dead but this is a simple change
  # that permits building on newer versions of macOS.
  patch do
    url "https://github.com/imkira/mobiledevice/pull/20.patch?full_index=1"
    sha256 "adb46783a6cce1e988e2efd3440e2991ac5c5ce55f59b9049c9ccc2936ae8a02"
  end

  def install
    (buildpath/"symlink_framework.sh").chmod 0555
    system "make", "install", "CC=#{ENV.cc}", "PREFIX=#{prefix}"
  end

  test do
    system "#{bin}/mobiledevice", "list_devices"
  end
end
