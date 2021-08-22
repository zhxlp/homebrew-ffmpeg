class Nu < Formula
  desc "Object-oriented, Lisp-like programming language"
  homepage "https://github.com/nulang/nu"
  url "https://github.com/nulang/nu/archive/v2.2.2.tar.gz"
  sha256 "7b1de5062ba2a87ee4cbf458f5f851a3c43473eec8aae3e17704e0dd4ff56b39"



  depends_on "pcre"

  fails_with :gcc do
    build 5666
    cause "nu only builds with clang"
  end

  def install
    ENV.delete("SDKROOT") if MacOS.version < :sierra
    ENV["PREFIX"] = prefix

    inreplace "Nukefile" do |s|
      s.gsub!('(SH "sudo ', '(SH "') # don't use sudo to install
      s.gsub!("\#{@destdir}/Library/Frameworks", "\#{@prefix}/Frameworks")
      s.sub! /^;; source files$/, <<~EOS
        ;; source files
        (set @framework_install_path "#{frameworks}")
      EOS
    end
    system "make"
    system "./mininush", "tools/nuke"
    bin.mkdir
    lib.mkdir
    include.mkdir
    system "./mininush", "tools/nuke", "install"
  end

  def caveats; <<~EOS
    Nu.framework was installed to:
      #{frameworks}/Nu.framework

    You may want to symlink this Framework to a standard macOS location,
    such as:
      ln -s "#{frameworks}/Nu.framework" /Library/Frameworks
  EOS
  end

  test do
    system bin/"nush", "-e", '(puts "Everything old is Nu again.")'
  end
end
