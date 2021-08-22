require "etc"

# Nethack the way God intended it to be played: from a terminal.
# This formula is based on Nethack formula.

class Jnethack < Formula
  desc "Japanese localization of Nethack"
  homepage "https://jnethack.osdn.jp/"
  url "https://downloads.sourceforge.net/project/nethack/nethack/3.4.3/nethack-343-src.tgz"
  version "3.4.3-0.11"
  sha256 "bb39c3d2a9ee2df4a0c8fdde708fbc63740853a7608d2f4c560b488124866fe4"



  # needs X11 locale for i18n
  depends_on :x11

  # Don't remove save folder
  skip_clean "libexec/save"

  patch do
    # Canonical: https://osdn.net/dl/jnethack/jnethack-3.4.3-0.11.diff.gz
    url "https://dotsrc.dl.osdn.net/osdn/jnethack/58545/jnethack-3.4.3-0.11.diff.gz"
    sha256 "fbc071f6b33c53d89e8f13319ced952e605499a21d2086077296c631caff7389"
  end

  # Patch from MacPorts' jnethack portfile
  patch do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/e9653f1/jnethack/3.4.3-0.11.patch"
    sha256 "6340de3784ee7b4d35fcf715ebbf08ec8e20214b0c2ae53f9c717afdae467c46"
  end

  def install
    # Build everything in-order; no multi builds.
    ENV.deparallelize

    ENV["HOMEBREW_CFLAGS"] = ENV.cflags

    # Symlink makefiles
    system "sh", "sys/unix/setup.sh"

    inreplace "include/config.h",
      /^#\s*define HACKDIR.*$/,
      "#define HACKDIR \"#{libexec}\""

    # Enable wizard mode for the current user
    wizard = Etc.getpwuid.name

    inreplace "include/config.h",
      /^#\s*define\s+WIZARD\s+"wizard"/,
      "#define WIZARD \"#{wizard}\""

    inreplace "include/config.h",
      /^#\s*define\s+WIZARD_NAME\s+"wizard"/,
      "#define WIZARD_NAME \"#{wizard}\""

    cd "dat" do
      system "make"

      %w[perm logfile].each do |f|
        touch f
        libexec.install f
      end

      # Stage the data
      libexec.install %w[jhelp jhh jcmdhelp jhistory jopthelp jwizhelp dungeon license data jdata.base joracles options jrumors.tru jrumors.fal quest.dat jquest.txt]
      libexec.install Dir["*.lev"]
    end

    # Make the game
    ENV.append_to_cflags "-I../include"
    cd "src" do
      system "make"
    end

    bin.install "src/jnethack"
    (libexec+"save").mkpath
  end
end
