class Gromacs < Formula
  desc "Versatile package for molecular dynamics calculations"
  homepage "http://www.gromacs.org/"
  url "https://ftp.gromacs.org/pub/gromacs/gromacs-2018.3.tar.gz"
  sha256 "4423a49224972969c52af7b1f151579cea6ab52148d8d7cbae28c183520aa291"



  depends_on "cmake" => :build
  depends_on "fftw"
  depends_on "gsl"

  def install
    inreplace "scripts/CMakeLists.txt", "CMAKE_INSTALL_BINDIR",
                                        "CMAKE_INSTALL_DATADIR"

    mkdir "build" do
      system "cmake", "..", *std_cmake_args, "-DGMX_GSL=ON"
      system "make"
      ENV.deparallelize { system "make", "install" }
    end

    bash_completion.install "build/scripts/GMXRC" => "gromacs-completion.bash"
    bash_completion.install "#{bin}/gmx-completion-gmx.bash" => "gmx-completion-gmx.bash"
    bash_completion.install "#{bin}/gmx-completion.bash" => "gmx-completion.bash"
    zsh_completion.install "build/scripts/GMXRC.zsh" => "_gromacs"
  end

  def caveats; <<~EOS
    GMXRC and other scripts installed to:
      #{HOMEBREW_PREFIX}/share/gromacs
  EOS
  end

  test do
    system "#{bin}/gmx", "help"
  end
end
