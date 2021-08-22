class ZeldaRothSe < Formula
  desc "Zelda Return of the Hylian SE"
  homepage "http://www.solarus-games.org/games/zelda-return-of-the-hylian-se/"
  head "https://github.com/christopho/zelda_roth_se.git"

  stable do
    url "https://github.com/christopho/zelda_roth_se/archive/v1.1.0.tar.gz"
    sha256 "95baf3ce96372b1ce78d9af8ee9723840474ac8fc51e87eb54cc35777d68f5a8"

    # Support SOLARUS_INSTALL_DATADIR variable for CMake
    patch do
      url "https://github.com/christopho/zelda_roth_se/commit/e9b5bd907f5b50b17d65ebe2fa50760d322c537c.diff?full_index=1"
      sha256 "061b93efdd16c450f7c3483e690099d96280250b159336439ab0da0ad5c2e13d"
    end
  end



  depends_on "cmake" => :build
  depends_on "solarus"

  def install
    system "cmake", ".", *std_cmake_args, "-DSOLARUS_INSTALL_DATADIR=#{share}"
    system "make", "install"
  end

  test do
    system Formula["solarus"].bin/"solarus-run", "-help"
    system "/usr/bin/unzip", share/"zelda_roth_se/data.solarus"
  end
end
