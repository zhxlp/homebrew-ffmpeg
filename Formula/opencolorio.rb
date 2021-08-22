class Opencolorio < Formula
  desc "Color management solution geared towards motion picture production"
  homepage "http://opencolorio.org/"
  url "https://github.com/imageworks/OpenColorIO/archive/v1.1.0.tar.gz"
  sha256 "228589879e1f11e455a555304007748a8904057088319ebbf172d9384b93c079"
  head "https://github.com/imageworks/OpenColorIO.git"



  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "little-cms2"
  depends_on "python@2"

  def install
    args = std_cmake_args
    args << "-DCMAKE_VERBOSE_MAKEFILE=OFF"

    mkdir "macbuild" do
      system "cmake", *args, ".."
      system "make"
      system "make", "install"
    end
  end

  def caveats
    <<~EOS
      OpenColorIO requires several environment variables to be set.
      You can source the following script in your shell-startup to do that:
        #{HOMEBREW_PREFIX}/share/ocio/setup_ocio.sh

      Alternatively the documentation describes what env-variables need set:
        http://opencolorio.org/installation.html#environment-variables

      You will require a config for OCIO to be useful. Sample configuration files
      and reference images can be found at:
        http://opencolorio.org/downloads.html
    EOS
  end

  test do
    assert_match "validate", shell_output("#{bin}/ociocheck --help", 1)
  end
end
