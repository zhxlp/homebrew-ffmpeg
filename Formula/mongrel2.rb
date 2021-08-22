class Mongrel2 < Formula
  desc "Application, language, and network architecture agnostic web server"
  homepage "https://mongrel2.org/"
  head "https://github.com/mongrel2/mongrel2.git", :branch => "develop"

  stable do
    url "https://github.com/mongrel2/mongrel2/releases/download/v1.11.0/mongrel2-v1.11.0.tar.bz2"
    sha256 "917f2ce07c0908cae63ac03f3039815839355d46568581902377ba7e41257bed"

    # ensure unit tests work on 1.11.0. remove after next release
    patch do
      url "https://github.com/mongrel2/mongrel2/commit/7cb8532e2ecc341d77885764b372a363fbc72eff.patch?full_index=1"
      sha256 "fa7be14bf1df8ec3ab8ae164bde8eb703e9e2665645aa627baae2f08c072db9a"
    end
  end



  depends_on "zeromq"

  def install
    # Build in serial. See:
    # https://github.com/Homebrew/homebrew/issues/8719
    ENV.deparallelize

    # Mongrel2 pulls from these ENV vars instead
    ENV["OPTFLAGS"] = "#{ENV.cflags} #{ENV.cppflags}"
    ENV["OPTLIBS"] = "#{ENV.ldflags} -undefined dynamic_lookup"

    system "make", "all"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    system bin/"m2sh", "help"
  end
end
