class Beansdb < Formula
  desc "Yet another distributed key-value storage system"
  homepage "https://github.com/douban/beansdb"
  url "https://github.com/douban/beansdb/archive/v0.7.1.4.tar.gz"
  sha256 "c89f267484dd47bab272b985ba0a9b9196ca63a9201fdf86963b8ed04f52ccdb"
  head "https://github.com/douban/beansdb.git"



  depends_on "autoconf" => :build
  depends_on "automake" => :build

  def install
    system "./autogen.sh"
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make"
    system "make", "install"

    (var/"db/beansdb").mkpath
    (var/"log").mkpath
  end

  plist_options :manual => "beansdb"

  def plist; <<~EOS
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>KeepAlive</key>
      <dict>
        <key>SuccessfulExit</key>
        <false/>
      </dict>
      <key>Label</key>
      <string>#{plist_name}</string>
      <key>ProgramArguments</key>
      <array>
        <string>#{opt_bin}/beansdb</string>
        <string>-p</string>
        <string>7900</string>
        <string>-H</string>
        <string>#{var}/db/beansdb</string>
        <string>-T</string>
        <string>1</string>
        <string>-vv</string>
      </array>
      <key>RunAtLoad</key>
      <true/>
      <key>WorkingDirectory</key>
      <string>#{var}</string>
      <key>StandardErrorPath</key>
      <string>#{var}/log/beansdb.log</string>
      <key>StandardOutPath</key>
      <string>#{var}/log/beansdb.log</string>
    </dict>
    </plist>
  EOS
  end

  test do
    system "#{bin}/beansdb", "-h"
  end
end
