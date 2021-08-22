class Atdtool < Formula
  desc "Command-line interface for After the Deadline language checker"
  homepage "https://github.com/lpenz/atdtool"
  url "https://github.com/lpenz/atdtool/archive/upstream/1.3.3.tar.gz"
  sha256 "3e928721388cf6f58b7e663ebc5508f26d180b1c07d5b8119212356c66e57fe8"
  revision 1



  depends_on "python"

  def install
    xy = Language::Python.major_minor_version "python3"
    ENV.prepend_create_path "PYTHONPATH", libexec/"lib/python#{xy}/site-packages"
    system "python3", *Language::Python.setup_install_args(libexec)
    bin.install Dir[libexec/"bin/*"]
    bin.env_script_all_files(libexec/"bin", :PYTHONPATH => ENV["PYTHONPATH"])
    prefix.install libexec/"share"
  end

  test do
    system "#{bin}/atdtool", "--help"
  end
end
