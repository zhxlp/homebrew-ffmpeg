# Installs a relatively minimalist version of the GPAC tools. The
# most commonly used tool in this package is the MP4Box metadata
# interleaver, which has relatively few dependencies.
#
# The challenge with building everything is that Gpac depends on
# a much older version of FFMpeg and WxWidgets than the version
# that Brew installs

class Gpac < Formula
  desc "Multimedia framework for research and academic purposes"
  homepage "https://gpac.wp.mines-telecom.fr/"
  revision 1
  head "https://github.com/gpac/gpac.git"

  stable do
    url "https://github.com/gpac/gpac/archive/v0.7.1.tar.gz"
    sha256 "c7a18b9eea1264fee392e7222d16b180e0acdd6bb173ff6b8baadbf50b3b1d7f"

    # Fix for CVE-2018-7752.
    patch do
      url "https://github.com/gpac/gpac/commit/90dc7f853d31b0a4e9441cba97feccf36d8b69a4.patch?full_index=1"
      sha256 "a31790cab731633e13fba815d851371314842bf8dedbdd4c749c9df9b5205312"
    end

    # Fix for CVE-2018-13005 & CVE-2018-13006.
    patch do
      url "https://github.com/gpac/gpac/commit/bceb03fd2be95097a7b409ea59914f332fb6bc86.patch?full_index=1"
      sha256 "716579315fa7ee9880f5b94d4bc906163a5d0e7b123041a66d69b27cfb22babe"
    end

    # Below two patches fix compile when building against recent versions of ffmpeg.
    patch do
      url "https://github.com/gpac/gpac/commit/b12b86e995db235e9a7e0c4fcd0fd54eb37bcee4.patch?full_index=1"
      sha256 "714bc320e9aac54782e5f4c661d5ae18f0fe002e23805d60bec4946725466d20"
    end

    patch do
      url "https://github.com/gpac/gpac/commit/855aafe47677de558a7dd5f772b8094b54bfe61a.patch?full_index=1"
      sha256 "dac3d143aef7fb399efefac16217902090b3868d624ff9d77317d71176a99f9b"
    end
  end



  depends_on "pkg-config" => :build
  depends_on "openssl"

  conflicts_with "bento4", :because => "both install `mp42ts` binaries"

  def install
    args = %W[
      --disable-wx
      --disable-pulseaudio
      --prefix=#{prefix}
      --mandir=#{man}
      --disable-x11
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/MP4Box", "-add", test_fixtures("test.mp3"), "#{testpath}/out.mp4"
    assert_predicate testpath/"out.mp4", :exist?
  end
end
