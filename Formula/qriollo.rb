class Qriollo < Formula
  desc "Impure functional language, based on Rioplatense Spanish"
  homepage "https://qriollo.github.io"
  url "https://qriollo.github.io/Qriollo-0.91.tar.gz"
  sha256 "c8357af8254a082d8e4da1de1bbf13bee27cfde8adb31ea0a5a0966bfbb7b28d"
  head "https://github.com/qriollo/qriollo.git"



  depends_on "ghc" => :build

  def install
    system "make"
    bin.install "qr"
    (lib/"chamuyo").install "Chamuyo.q"
  end

  def caveats
    <<~EOS
      The standard module "Chamuyo.q" has been placed in:
        #{lib}/chamuyo
    EOS
  end

  test do
    test_file_name = "HolaMundo.q"
    (testpath/test_file_name).write <<~EOS
      enchufar Chamuyo
      el programa es
         escupir "Hola mundo\n"
    EOS
    system bin/"qr", "--ruta", "#{lib/"chamuyo"}:#{testpath}", test_file_name
  end
end
