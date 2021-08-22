class SshPermitA38 < Formula
  desc "Central management and deployment for SSH keys"
  homepage "https://github.com/ierror/ssh-permit-a38"
  url "https://github.com/ierror/ssh-permit-a38/archive/v0.2.0.tar.gz"
  sha256 "cb8d94954c0e68eb86e3009d6f067b92464f9c095b6a7754459cfce329576bd9"



  depends_on "cmake" => :build
  depends_on "rust" => :build
  depends_on "openssl"

  def install
    # Ensure that the `openssl` crate picks up the intended library.
    # https://crates.io/crates/openssl#manual-configuration
    ENV["OPENSSL_DIR"] = Formula["openssl"].opt_prefix

    system "cargo", "install", "--root", prefix, "--path", "."
  end

  test do
    system bin/"ssh-permit-a38 host 1.exmaple.com add"

    assert(File.readlines("ssh-permit.json").grep(/1.exmaple.com/).size == 1, "Test host not found in ssh-permit.json")
  end
end
