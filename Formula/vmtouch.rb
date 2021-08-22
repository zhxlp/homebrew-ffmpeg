class Vmtouch < Formula
  desc "Portable file system cache diagnostics and control"
  homepage "https://hoytech.com/vmtouch/"
  url "https://github.com/hoytech/vmtouch/archive/v1.3.0.tar.gz"
  sha256 "4615980b8f824c8eb164e50ec0880bcb71591f4e3989a6075e5a3e2efd122ceb"
  head "https://github.com/hoytech/vmtouch.git"



  def install
    system "make", "install", "PREFIX=#{prefix}", "MANDIR=#{man}"
  end

  test do
    system bin/"vmtouch", bin/"vmtouch"
  end
end
