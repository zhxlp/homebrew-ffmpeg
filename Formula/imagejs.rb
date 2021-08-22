class Imagejs < Formula
  desc "Tool to hide JavaScript inside valid image files"
  homepage "https://jklmnn.de/imagejs/"
  url "https://github.com/jklmnn/imagejs/archive/0.7.2.tar.gz"
  sha256 "ba75c7ea549c4afbcb2a516565ba0b762b5fc38a03a48e5b94bec78bac7dab07"
  head "https://github.com/jklmnn/imagejs.git"



  def install
    system "make"
    bin.install "imagejs"
  end

  test do
    (testpath/"test.js").write "alert('Hello World!')"
    system "#{bin}/imagejs", "bmp", "test.js", "-l"
  end
end
