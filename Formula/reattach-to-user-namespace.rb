class ReattachToUserNamespace < Formula
  desc "Reattach process (e.g., tmux) to background"
  homepage "https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard"
  url "https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard/archive/v2.7.tar.gz"
  sha256 "7b49536afee3823065cd0772d5110d6814fafa9e8b66432ab537b3e891f4b202"
  head "https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard.git"



  def install
    system "make"
    bin.install "reattach-to-user-namespace"
  end

  test do
    system bin/"reattach-to-user-namespace", "-l", "bash", "-c", "echo Hello World!"
  end
end
