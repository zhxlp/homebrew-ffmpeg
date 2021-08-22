class Oauth2Proxy < Formula
  desc "Reverse proxy for authenticating users via OAuth 2 providers"
  homepage "https://github.com/bitly/oauth2_proxy"
  url "https://github.com/bitly/oauth2_proxy/archive/v2.2.tar.gz"
  sha256 "dae9bae213ccf2a98bf36177e04c1edf4688989c58c383525258956679ddcc19"
  head "https://github.com/bitly/oauth2_proxy.git"



  depends_on "go" => :build
  depends_on "gpm" => :build

  def install
    mkdir_p "#{buildpath}/src/github.com/bitly"
    ln_s buildpath, "#{buildpath}/src/github.com/bitly/oauth2_proxy"

    ENV["GOPATH"] = buildpath

    system "gpm", "install"
    system "go", "build", "-o", "#{bin}/oauth2_proxy"
    (etc/"oauth2_proxy").install "contrib/oauth2_proxy.cfg.example"
  end

  def caveats; <<~EOS
    #{etc}/oauth2_proxy/oauth2_proxy.cfg must be filled in.
  EOS
  end

  plist_options :manual => "oauth2_proxy"

  def plist; <<~EOS
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>RunAtLoad</key>
        <true/>
        <key>KeepAlive</key>
        <true/>
        <key>ProgramArguments</key>
        <array>
            <string>#{opt_bin}/oauth2_proxy</string>
            <string>--config=#{etc}/oauth2_proxy/oauth2_proxy.cfg</string>
        </array>
        <key>WorkingDirectory</key>
        <string>#{HOMEBREW_PREFIX}</string>
      </dict>
    </plist>
  EOS
  end

  test do
    require "socket"
    require "timeout"

    # Get an unused TCP port.
    server = TCPServer.new(0)
    port = server.addr[1]
    server.close

    pid = fork do
      exec "#{bin}/oauth2_proxy",
        "--client-id=testing",
        "--client-secret=testing",
        "--cookie-secret=testing",
        "--http-address=127.0.0.1:#{port}",
        "--upstream=file:///tmp",
        "-email-domain=*"
    end

    begin
      Timeout.timeout(10) do
        loop do
          Utils.popen_read "curl", "-s", "http://127.0.0.1:#{port}"
          break if $CHILD_STATUS.exitstatus.zero?
          sleep 1
        end
      end
    ensure
      Process.kill("TERM", pid)
      Process.wait(pid)
    end
  end
end
