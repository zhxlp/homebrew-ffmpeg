class RustupInit < Formula
  desc "The Rust toolchain installer"
  homepage "https://github.com/rust-lang/rustup.rs"
  url "https://github.com/rust-lang/rustup.rs/archive/1.16.0.tar.gz"
  sha256 "8c4ffeda2088dbdd5ea2eac8acef5ddd57dfcfe1f06a503e3da790f93161e1a6"



  depends_on "rust" => :build

  # Fixes `rustup-init` not working when it is relative symlink.
  # https://github.com/rust-lang/rustup.rs/issues/1512
  # https://github.com/rust-lang/rustup.rs/pull/1521
  patch do
    url "https://github.com/rust-lang/rustup.rs/pull/1521/commits/ebbfced7ee4aeb5be4c775f8f85e351093d5818f.diff?full_index=1"
    sha256 "34dc006d75d747b99dd9fe49bdde396a8bf5443d1e3df1a47c4776c06ec3f3c7"
  end

  def install
    cargo_home = buildpath/"cargo_home"
    cargo_home.mkpath
    ENV["CARGO_HOME"] = cargo_home

    system "cargo", "install", "--root", prefix, "--path", ".",
                    "--features", "no-self-update"
  end

  test do
    ENV["CARGO_HOME"] = testpath/".cargo"
    ENV["RUSTUP_HOME"] = testpath/".multirust"

    system bin/"rustup-init", "-y"
    (testpath/"hello.rs").write <<~EOS
      fn main() {
        println!("Hello World!");
      }
    EOS
    system testpath/".cargo/bin/rustc", "hello.rs"
    assert_equal "Hello World!", shell_output("./hello").chomp
  end
end
