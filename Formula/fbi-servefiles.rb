class FbiServefiles < Formula
  include Language::Python::Virtualenv

  desc "Serve local files to Nintendo 3DS via FBI remote installer"
  homepage "https://github.com/Steveice10/FBI"
  url "https://github.com/Steveice10/FBI/archive/2.6.0.tar.gz"
  sha256 "4948d4c53d754cc411b51edbf35c609ba514ae21d9d0e8f4b66a26d5c666be68"



  depends_on "python"

  def install
    venv = virtualenv_create(libexec, "python3")
    venv.pip_install_and_link buildpath/"servefiles"
  end

  test do
    require "socket"

    def test_socket
      server = TCPServer.new(5000)
      client = server.accept
      client.puts "\n"
      client_response = client.gets
      client.close
      server.close
      client_response
    end

    begin
      pid = fork do
        system "#{bin}/sendurls.py", "127.0.0.1", "https://github.com"
      end
      assert_match "https://github.com", test_socket
    ensure
      Process.kill("TERM", pid)
      Process.wait(pid)
    end

    begin
      touch "test.cia"
      pid = fork do
        system "#{bin}/servefiles.py", "127.0.0.1", "test.cia", "127.0.0.1", "8080"
      end
      assert_match "127.0.0.1:8080/test.cia", test_socket
    ensure
      Process.kill("TERM", pid)
      Process.wait(pid)
    end
  end
end
