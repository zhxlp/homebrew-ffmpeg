class Falcon < Formula
  desc "Multi-paradigm programming language and scripting engine"
  homepage "http://www.falconpl.org/"
  url "https://mirrorservice.org/sites/distfiles.macports.org/falcon/Falcon-0.9.6.8.tgz"
  mirror "https://src.fedoraproject.org/repo/pkgs/Falcon/Falcon-0.9.6.8.tgz/8435f6f2fe95097ac2fbe000da97c242/Falcon-0.9.6.8.tgz"
  sha256 "f4b00983e7f91a806675d906afd2d51dcee048f12ad3af4b1dadd92059fa44b9"



  depends_on "cmake" => :build
  depends_on "pcre"

  conflicts_with "sdl",
    :because => "Falcon optionally depends on SDL and then the build breaks. Fix it!"

  def install
    args = std_cmake_args + %W[
      -DFALCON_BIN_DIR=#{bin}
      -DFALCON_LIB_DIR=#{lib}
      -DFALCON_MAN_DIR=#{man1}
      -DFALCON_WITH_EDITLINE=OFF
      -DFALCON_WITH_FEATHERS=NO
      -DFALCON_WITH_INTERNAL_PCRE=OFF
      -DFALCON_WITH_MANPAGES=ON
    ]

    system "cmake", *args
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test").write <<~EOS
      looper = .[brigade
         .[{ val, text => oob( [val+1, "Changed"] ) }
           { val, text => val < 10 ? oob(1): "Homebrew" }]]
      final = looper( 1, "Original" )
      > "Final value is: ", final
    EOS

    assert_match(/Final value is: Homebrew/,
                 shell_output("#{bin}/falcon test").chomp)
  end
end
