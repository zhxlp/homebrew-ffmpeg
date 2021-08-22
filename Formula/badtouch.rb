class Badtouch < Formula
  desc "Scriptable network authentication cracker"
  homepage "https://github.com/kpcyrd/badtouch"
  url "https://github.com/kpcyrd/badtouch/archive/v0.6.1.tar.gz"
  sha256 "62181ac05a68a552e1984dd42206f6a5ca195e51addc48cbfdf55a60afc7c3ae"



  depends_on "rust" => :build
  depends_on "openssl"

  def install
    # Ensure that the `openssl` crate picks up the intended library.
    # https://crates.io/crates/openssl#manual-configuration
    ENV["OPENSSL_DIR"] = Formula["openssl"].opt_prefix

    system "cargo", "install", "--root", prefix, "--path", "."
    man1.install "docs/badtouch.1"
  end

  test do
    (testpath/"true.lua").write <<~EOS
      descr = "always true"

      function verify(user, password)
          return true
      end
    EOS
    system "#{bin}/badtouch", "oneshot", "-vvx", testpath/"true.lua", "foo"
  end
end
