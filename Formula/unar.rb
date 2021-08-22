class Unar < Formula
  desc "Command-line unarchiving tools supporting multiple formats"
  homepage "https://unarchiver.c3.cx/commandline"
  url "https://wakaba.c3.cx/releases/TheUnarchiver/unar1.10.1_src.zip"
  version "1.10.1"
  sha256 "40967014a505b7a27864c49dc3b5d30b98ae4e6d4873783b2ef9ef9215fd092b"
  head "https://bitbucket.org/WAHa_06x36/theunarchiver", :using => :hg



  depends_on :xcode => :build

  # Fix build for Xcode 10 but remove libstdc++.6.dylib and linking libc++.dylib instead
  patch do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/a94f6f/unar/xcode10.diff"
    sha256 "d4ac4abe6f6bcc2175efab6be615432b5a8093f8bfc99fba21552bc820b29703"
  end

  def install
    # ZIP for 1.10.1 additionally contains a `__MACOSX` directory, preventing
    # stripping of the first path component during extraction of the archive.
    mv Dir["The Unarchiver/*"], "."

    args = %W[
      -project ./XADMaster/XADMaster.xcodeproj
      SYMROOT=..
      -configuration Release
      MACOSX_DEPLOYMENT_TARGET=#{MacOS.version}
    ]

    # Build XADMaster.framework, unar and lsar
    xcodebuild "-target", "XADMaster", *args
    xcodebuild "-target", "unar", *args
    xcodebuild "-target", "lsar", *args

    bin.install "./Release/unar", "./Release/lsar"
    lib.install "./Release/libXADMaster.a"
    frameworks.install "./Release/XADMaster.framework"
    (include/"libXADMaster").install_symlink Dir["#{frameworks}/XADMaster.framework/Headers/*"]

    cd "./Extra" do
      man1.install "lsar.1", "unar.1"
      bash_completion.install "unar.bash_completion", "lsar.bash_completion"
    end
  end

  test do
    cp prefix/"README.md", "."
    system "gzip", "README.md"
    assert_equal "README.md.gz: Gzip\nREADME.md\n", shell_output("#{bin}/lsar README.md.gz")
    system bin/"unar", "README.md.gz"
    assert_predicate testpath/"README.md", :exist?
  end
end
