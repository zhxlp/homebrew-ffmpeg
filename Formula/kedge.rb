class Kedge < Formula
  desc "Deployment tool for Kubernetes artifacts"
  homepage "http://kedgeproject.org/"
  url "https://github.com/kedgeproject/kedge/archive/v0.12.0.tar.gz"
  sha256 "3c01880ba9233fe5b0715527ba32f0c59b25b73284de8cfb49914666a158487b"



  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/kedgeproject").mkpath
    ln_s buildpath, buildpath/"src/github.com/kedgeproject/kedge"
    system "make", "bin"
    bin.install "kedge"
  end

  test do
    (testpath/"kedgefile.yml").write <<~EOS
      name: test
      deployments:
      - containers:
        - image: test
    EOS
    output = shell_output("#{bin}/kedge generate -f kedgefile.yml")
    assert_match "name: test", output
  end
end
