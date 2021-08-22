class Darkice < Formula
  desc "Live audio streamer"
  homepage "http://www.darkice.org/"
  url "https://downloads.sourceforge.net/project/darkice/darkice/1.3/darkice-1.3.tar.gz"
  sha256 "2c0d0faaa627c0273b2ce8b38775a73ef97e34ef866862a398f660ad8f6e9de6"
  revision 1



  depends_on "pkg-config" => :build
  depends_on "faac"
  depends_on "jack"
  depends_on "lame"
  depends_on "libsamplerate"
  depends_on "libvorbis"
  depends_on "two-lame"

  def install
    # Fixes  "invalid conversion from 'const float*' to 'float*' [-fpermissive]"
    # Upstream issue Oct 25, 2016 https://github.com/rafael2k/darkice/issues/119
    # Suggested fix  Oct 25, 2016 https://github.com/rafael2k/darkice/pull/120
    ["aacPlusEncoder.cpp", "FaacEncoder.cpp", "OpusLibEncoder.cpp", "VorbisLibEncoder.cpp"].each do |f|
      inreplace "src/#{f}", ", converterData.data_in", ", const_cast<float*>( converterData.data_in )"
    end
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--sysconfdir=#{etc}",
                          "--with-lame-prefix=#{Formula["lame"].opt_prefix}",
                          "--with-faac-prefix=#{Formula["faac"].opt_prefix}",
                          "--with-twolame",
                          "--with-jack",
                          "--with-vorbis",
                          "--with-samplerate"
    system "make", "install"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/darkice -h", 1)
  end
end
