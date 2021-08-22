class Minica < Formula
  desc "Small, simple certificate authority"
  homepage "https://github.com/jsha/minica"
  url "https://github.com/jsha/minica/archive/v1.0.1.tar.gz"
  sha256 "d5fd5259642dcd8ff98cb81deb4c66424a97c7bee2670622a6a057a6de5cfd03"



  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/jsha").mkpath
    ln_s buildpath, buildpath/"src/github.com/jsha/minica"
    system "go", "build", "-o", bin/"minica", "github.com/jsha/minica"
  end

  test do
    system "#{bin}/minica", "--domains", "foo.com"
    assert_predicate testpath/"minica.pem", :exist?
  end
end
