require "etc"

# Bugfixed and interface-patched Nethack.
#
# This formula is based on the Nethack formula, and includes the
# patches from same. The original notes from the Nethack formula
# follow:
# - @jterk
#
# Nethack the way God intended it to be played: from a terminal.
# This build script was created referencing:
# * https://nethackwiki.com/wiki/Compiling#On_Mac_OS_X
# * https://nethackwiki.com/wiki/Pkgsrc#patch-ac_.28system.h.29
# and copious hacking until things compiled.
#
# The patch applied incorporates the patch-ac above, the OS X
# instructions from the Wiki, and whatever else needed to be
# done.
# - @adamv

class Nethacked < Formula
  desc "Bugfixed and interface-patched Nethack"
  homepage "https://nethacked.github.io/"
  url "https://github.com/nethacked/nethacked/archive/1.0.tar.gz"
  sha256 "4e3065a7b652d5fc21577e0b7ac3a60513cd30f4ee81c7f11431a71185b609aa"



  # Don't remove save folder
  skip_clean "libexec/save"

  patch do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/b40e459/nethacked/1.0.patch"
    sha256 "d32bed5e7b4500515135270d72077bab49534abbdc60d8d040473fbee630f90f"
  end

  def install
    # Build everything in-order; no multi builds.
    ENV.deparallelize

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
      # Make the data first, before we munge the CFLAGS
      system "make"
      %w[perm logfile].each do |f|
        touch f
        libexec.install f
      end

      # Stage the data
      libexec.install %w[help hh cmdhelp history opthelp wizhelp dungeon license data oracles options rumors quest.dat]
      libexec.install Dir["*.lev"]
    end

    # Make the game
    ENV.append_to_cflags "-I../include"
    cd "src" do
      system "make"
    end

    bin.install "src/nethacked"
    (libexec+"save").mkpath

    # These need to be group-writable in multi-user situations
    chmod "g+w", libexec
    chmod "g+w", libexec+"save"
  end
end
