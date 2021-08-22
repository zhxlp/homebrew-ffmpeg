class Iperf < Formula
  desc "Tool to measure maximum TCP and UDP bandwidth"
  homepage "https://sourceforge.net/projects/iperf2/"
  url "https://downloads.sourceforge.net/project/iperf2/iperf-2.0.12.tar.gz"
  sha256 "367f651fb1264b13f6518e41b8a7e08ce3e41b2a1c80e99ff0347561eed32646"



  def install
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    begin
      server = IO.popen("#{bin}/iperf --server")
      sleep 1
      assert_match "Bandwidth", pipe_output("#{bin}/iperf --client 127.0.0.1 --time 1")
    ensure
      Process.kill("SIGINT", server.pid)
      Process.wait(server.pid)
    end
  end
end
