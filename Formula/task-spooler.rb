class TaskSpooler < Formula
  desc "Batch system to run tasks one after another"
  homepage "https://vicerveza.homeunix.net/~viric/soft/ts/"
  url "https://vicerveza.homeunix.net/~viric/soft/ts/ts-1.0.tar.gz"
  sha256 "4f53e34fff0bb24caaa44cdf7598fd02f3e5fa7cacaea43fa0d081d03ffbb395"



  if Tab.for_name("moreutils").with?("ts")
    conflicts_with "moreutils", :because => "both install a `ts` executable."
  end

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    system "#{bin}/ts", "-l"
  end
end
