class GribApi < Formula
  desc "Encode and decode grib messages (editions 1 and 2)"
  homepage "https://software.ecmwf.int/wiki/display/GRIB/Home"
  url "https://mirrors.ocf.berkeley.edu/debian/pool/main/g/grib-api/grib-api_1.27.0.orig.tar.xz"
  mirror "https://mirrorservice.org/sites/ftp.debian.org/debian/pool/main/g/grib-api/grib-api_1.27.0.orig.tar.xz"
  sha256 "81078fb9946c38cd292c4eaa50f0acf0093f709a247e83493b3181955177ba09"
  revision 1



  depends_on "cmake" => :build
  depends_on "gcc" # for gfortran
  depends_on "jasper"
  depends_on "libpng"
  depends_on "numpy"

  conflicts_with "eccodes",
    :because => "grib-api and eccodes install the same binaries."

  def install
    # Fix "no member named 'inmem_' in 'jas_image_t'"
    inreplace "src/grib_jasper_encoding.c", "image.inmem_    = 1;", ""

    inreplace "CMakeLists.txt", "find_package( OpenJPEG )", ""

    mkdir "build" do
      system "cmake", "..", *std_cmake_args, "-DENABLE_NETCDF=OFF",
                            "-DENABLE_PNG=ON",
                            "-DPNG_PNG_INCLUDE_DIR=#{Formula["libpng"].opt_include}"
      system "make", "install"
    end
  end

  test do
    grib_samples_path = shell_output("#{bin}/grib_info -t").strip
    system bin/"grib_ls", "#{grib_samples_path}/GRIB1.tmpl"
    system bin/"grib_ls", "#{grib_samples_path}/GRIB2.tmpl"
  end
end
