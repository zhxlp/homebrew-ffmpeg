class Gpsd < Formula
  desc "Global Positioning System (GPS) daemon"
  homepage "http://catb.org/gpsd/"
  url "https://download.savannah.gnu.org/releases/gpsd/gpsd-3.17.tar.gz"
  sha256 "68e0dbecfb5831997f8b3d6ba48aed812eb465d8c0089420ab68f9ce4d85e77a"



  depends_on "scons" => :build

  def install
    system "scons", "chrpath=False", "python=False", "strip=False", "prefix=#{prefix}/"
    system "scons", "install"
  end

  def caveats; <<~EOS
    gpsd does not automatically detect GPS device addresses. Once started, you
    need to force it to connect to your GPS:

      GPSD_SOCKET="#{var}/gpsd.sock" #{sbin}/gpsdctl add /dev/tty.usbserial-XYZ
  EOS
  end

  plist_options :manual => "#{HOMEBREW_PREFIX}/sbin/gpsd -N -F #{HOMEBREW_PREFIX}/var/gpsd.sock /dev/tty.usbserial-XYZ"

  def plist; <<~EOS
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>Label</key>
      <string>#{plist_name}</string>
      <key>ProgramArguments</key>
      <array>
        <string>#{opt_sbin}/gpsd</string>
        <string>-N</string>
        <string>-F</string>
        <string>#{var}/gpsd.sock</string>
      </array>
      <key>RunAtLoad</key>
      <true/>
      <key>KeepAlive</key>
      <true/>
      <key>WorkingDirectory</key>
      <string>#{HOMEBREW_PREFIX}</string>
      <key>StandardOutPath</key>
      <string>#{var}/log/gpsd.log</string>
      <key>StandardErrorPath</key>
      <string>#{var}/log/gpsd.log</string>
    </dict>
    </plist>
  EOS
  end

  test do
    assert_match version.to_s, shell_output("#{sbin}/gpsd -V")
  end
end
