class Gearboy < Formula
  desc "Nintendo Game Boy (Color) emulator"
  homepage "https://github.com/drhelius/Gearboy"
  url "https://github.com/drhelius/Gearboy/archive/gearboy-2.3.1.tar.gz"
  sha256 "a1976a82f57d14e625339b50f11cd53da7c6ac1d92ececc4d2b5d163fba4a0ec"
  revision 1
  head "https://github.com/drhelius/Gearboy.git"



  depends_on "qt"
  depends_on "sdl2"

  def install
    cd "platforms/macosx/Gearboy" do
      inreplace "Gearboy.pro" do |s|
        s.gsub! "/usr/local/include", Formula["sdl2"].include
        s.gsub! "/usr/local/lib", Formula["sdl2"].lib
      end
      system "#{Formula["qt"].bin}/qmake", "PREFIX=#{prefix}", "CONFIG+=c++11"
      system "make"
      prefix.install "Gearboy.app"
      bin.write_exec_script "#{prefix}/Gearboy.app/Contents/MacOS/Gearboy"
    end
  end
end
