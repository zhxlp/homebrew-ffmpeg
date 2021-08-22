class CrosstoolNg < Formula
  desc "Tool for building toolchains"
  homepage "https://crosstool-ng.github.io/"
  url "http://crosstool-ng.org/download/crosstool-ng/crosstool-ng-1.23.0.tar.xz"
  sha256 "68a43ea98ccf9cb345cb6eec494a497b224fee24c882e8c14c6713afbbe79196"
  revision 3
  head "https://github.com/crosstool-ng/crosstool-ng.git"



  depends_on "help2man" => :build
  depends_on "autoconf"
  depends_on "automake"
  depends_on "binutils"
  depends_on "coreutils"
  depends_on "flex"
  depends_on "gawk"
  depends_on "gnu-sed"
  depends_on "grep"
  depends_on "libtool"
  depends_on "m4"
  depends_on "make"
  depends_on "ncurses" if DevelopmentTools.clang_build_version >= 1000
  depends_on "xz"

  if build.head?
    depends_on "bash"
    depends_on "bison"
    depends_on "gettext"
  end

  def install
    if build.head?
      system "./bootstrap"
      ENV["BISON"] = "#{Formula["bison"].opt_bin}/bison"
      ENV.append "LDFLAGS", "-lintl"
    end

    ENV["M4"] = "#{Formula["m4"].opt_bin}/m4"
    ENV["MAKE"] = "#{Formula["make"].opt_bin}/gmake"

    system "./configure", "--prefix=#{prefix}"

    # Must be done in two steps
    system "make"
    system "make", "install"
  end

  test do
    assert_match "This is crosstool-NG", shell_output("make -rf #{bin}/ct-ng version")
  end
end
