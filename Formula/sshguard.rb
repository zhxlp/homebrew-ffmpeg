class Sshguard < Formula
  desc "Protect from brute force attacks against SSH"
  homepage "https://www.sshguard.net/"
  url "https://downloads.sourceforge.net/project/sshguard/sshguard/2.2.0/sshguard-2.2.0.tar.gz"
  sha256 "2aff07fee6ec33e4ffd5411916b75189977af1d77b86dac5f3834dd3aa3656c2"
  revision 1
  version_scheme 1



  head do
    url "https://bitbucket.org/sshguard/sshguard.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "docutils" => :build
  end

  def install
    system "autoreconf", "-fiv" if build.head?
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}",
                          "--sysconfdir=#{etc}"
    system "make", "install"
    inreplace man8/"sshguard.8", "%PREFIX%/etc/", "#{etc}/"
    cp "examples/sshguard.conf.sample", "examples/sshguard.conf"
    inreplace "examples/sshguard.conf" do |s|
      s.gsub! /^#BACKEND=.*$/, "BACKEND=\"#{opt_libexec}/sshg-fw-pf\""
      if MacOS.version >= :sierra
        s.gsub! %r{^#LOGREADER="/usr/bin/log}, "LOGREADER=\"/usr/bin/log"
      else
        s.gsub! /^#FILES.*$/, "FILES=/var/log/system.log"
      end
    end
    etc.install "examples/sshguard.conf"
  end

  def caveats
    <<~EOS
      Add the following lines to /etc/pf.conf to block entries in the sshguard
      table (replace $ext_if with your WAN interface):

        table <sshguard> persist
        block in quick on $ext_if proto tcp from <sshguard> to any port 22 label "ssh bruteforce"

      Then run sudo pfctl -f /etc/pf.conf to reload the rules.
    EOS
  end

  plist_options :startup => true

  def plist; <<~EOS
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>Label</key>
      <string>#{plist_name}</string>
      <key>KeepAlive</key>
      <true/>
      <key>ProgramArguments</key>
      <array>
        <string>#{opt_sbin}/sshguard</string>
      </array>
      <key>RunAtLoad</key>
      <true/>
    </dict>
    </plist>
  EOS
  end

  test do
    require "pty"
    PTY.spawn(sbin/"sshguard", "-v") do |r, _w, pid|
      begin
        assert_equal "SSHGuard #{version}", r.read.strip
      ensure
        Process.wait pid
      end
    end
  end
end
