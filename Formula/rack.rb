class Rack < Formula
  desc "CLI for Rackspace"
  homepage "https://github.com/rackspace/rack"
  url "https://github.com/rackspace/rack.git",
      :tag      => "1.2",
      :revision => "09c14b061f4a115c8f1ff07ae6be96d9b11e08df"
  head "https://github.com/rackspace/rack.git"



  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    ENV["TRAVIS_TAG"] = version

    rackpath = buildpath/"src/github.com/rackspace/rack"
    rackpath.install Dir["{*,.??*}"]

    cd rackpath do
      # This is a slightly grim hack to handle the weird logic around
      # deciding whether to add a = or not on the ldflags, as mandated
      # by Go 1.7+.
      # https://github.com/rackspace/rack/issues/446
      inreplace "script/build", "go1.5", Utils.popen_read("go version")[/go1\.\d/]

      ln_s "internal", "vendor"
      system "script/build", "rack"
      bin.install "rack"
      prefix.install_metafiles
    end
  end

  test do
    system "#{bin}/rack"
  end
end
