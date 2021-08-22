class Runit < Formula
  desc "Collection of tools for managing UNIX services"
  homepage "http://smarden.org/runit"
  url "http://smarden.org/runit/runit-2.1.2.tar.gz"
  sha256 "6fd0160cb0cf1207de4e66754b6d39750cff14bb0aa66ab49490992c0c47ba18"



  def install
    # Runit untars to 'admin/runit-VERSION'
    cd "runit-#{version}" do
      # Per the installation doc on macOS, we need to make a couple changes.
      system "echo 'cc -Xlinker -x' >src/conf-ld"
      inreplace "src/Makefile", / -static/, ""

      inreplace "src/sv.c", "char *varservice =\"/service/\";", "char *varservice =\"#{var}/service/\";"
      system "package/compile"

      # The commands are compiled and copied into the 'command' directory and
      # names added to package/commands. Read the file for the commands and
      # install them in homebrew.
      rcmds = File.read("package/commands")

      rcmds.split("\n").each do |r|
        bin.install("command/#{r.chomp}")
        man8.install("man/#{r.chomp}.8")
      end

      (var + "service").mkpath
    end
  end

  def caveats; <<~EOS
    This formula does not install runit as a replacement for init.
    The service directory is #{var}/service instead of /service.

    To have runit ready to run services, start runsvdir:
         runsvdir -P #{var}/service

    Depending on the services managed by runit, this may need to start as root.
  EOS
  end
end
