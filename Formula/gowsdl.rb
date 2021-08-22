class Gowsdl < Formula
  desc "WSDL2Go code generation as well as its SOAP proxy"
  homepage "https://github.com/hooklift/gowsdl"
  url "https://github.com/hooklift/gowsdl.git",
      :tag      => "v0.3.1",
      :revision => "2375731131398bde30666dc45b48cd92f937de98"
  head "https://github.com/hooklift/gowsdl.git"



  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath

    srcpath = buildpath/"src/github.com/hooklift/gowsdl"
    srcpath.install buildpath.children
    srcpath.cd do
      system "make", "build"
      bin.install "build/gowsdl"
    end
  end

  test do
    system "#{bin}/gowsdl"
  end
end
