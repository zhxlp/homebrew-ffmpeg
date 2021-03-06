class Platypus < Formula
  desc "Create macOS applications from {Perl,Ruby,sh,Python} scripts"
  homepage "https://sveinbjorn.org/platypus"
  url "https://sveinbjorn.org/files/software/platypus/platypus5.2.src.zip"
  sha256 "0c0201804e13c09a33fe95ba715ed995872d35d3cdfa2cb694cf378980ed4c08"
  head "https://github.com/sveinbjornt/Platypus.git"



  depends_on :xcode => ["8.0", :build]

  def install
    xcodebuild "SYMROOT=build", "DSTROOT=#{buildpath}/dst",
               "-project", "Platypus.xcodeproj",
               "-target", "platypus",
               "-target", "ScriptExec",
               "clean",
               "install"

    man1.install "CommandLineTool/man/platypus.1"
    bin.install "dst/platypus_clt" => "platypus"

    cd "build/UninstalledProducts/macosx/ScriptExec.app/Contents" do
      pkgshare.install "Resources/MainMenu.nib", "MacOS/ScriptExec"
    end
  end

  def caveats; <<~EOS
    This formula only installs the command-line Platypus tool, not the GUI.

    The GUI can be downloaded from Platypus' website:
      https://sveinbjorn.org/platypus

    Alternatively, install with Homebrew Cask:
      brew cask install platypus
  EOS
  end

  test do
    system "#{bin}/platypus", "-v"
  end
end
