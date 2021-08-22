class Hyperkit < Formula
  desc "Toolkit for embedding hypervisor capabilities in your application"
  homepage "https://github.com/moby/hyperkit"
  url "https://github.com/moby/hyperkit/archive/v0.20180403.tar.gz"
  sha256 "e2739b034f20d9437696de48ace42600f55b7213292ec255032b2ef55f508297"



  depends_on "aspcud" => :build
  depends_on "ocaml" => :build
  depends_on "opam" => :build
  depends_on :xcode => ["9.0", :build]

  depends_on "libev"

  resource "tinycorelinux" do
    url "https://dl.bintray.com/markeissler/homebrew/hyperkit-kernel/tinycorelinux_8.x.tar.gz"
    sha256 "560c1d2d3a0f12f9b1200eec57ca5c1d107cf4823d3880e09505fcd9cd39141a"
  end

  def install
    system "opam", "init", "--no-setup"
    opam_dir = "#{buildpath}/.brew_home/.opam"
    ENV["CAML_LD_LIBRARY_PATH"] = "#{opam_dir}/system/lib/stublibs:#{Formula["ocaml"].opt_lib}/ocaml/stublibs"
    ENV["OPAMUTF8MSGS"] = "1"
    ENV["PERL5LIB"] = "#{opam_dir}/system/lib/perl5"
    ENV["OCAML_TOPLEVEL_PATH"] = "#{opam_dir}/system/lib/toplevel"
    ENV.prepend_path "PATH", "#{opam_dir}/system/bin"

    inreplace "#{opam_dir}/compilers/4.05.0/4.05.0/4.05.0.comp",
      '["./configure"', '["./configure" "-no-graph"' # Avoid X11

    ENV.deparallelize { system "opam", "switch", "4.05.0" }

    system "opam", "config", "exec", "--",
           "opam", "install", "-y", "uri", "qcow", "conduit.1.0.0", "lwt.3.1.0",
           "qcow-tool", "mirage-block-unix.2.9.0", "conf-libev", "logs", "fmt",
           "mirage-unix", "prometheus-app"

    args = []
    args << "GIT_VERSION=#{version}"
    system "opam", "config", "exec", "--", "make", *args

    bin.install "build/hyperkit"
    man1.install "hyperkit.1"
  end

  test do
    assert_match(version.to_s, shell_output("#{bin}/hyperkit -v 2>&1"))

    if Hardware::CPU.features.include? :vmx
      resource("tinycorelinux").stage do |context|
        tmpdir = context.staging.tmpdir
        path_resource_versioned = Dir.glob(tmpdir.join("tinycorelinux_[0-9]*"))[0]
        cp(File.join(path_resource_versioned, "vmlinuz"), testpath)
        cp(File.join(path_resource_versioned, "initrd.gz"), testpath)
      end

      (testpath / "test_hyperkit.exp").write <<-EOS
        #!/usr/bin/env expect -d
        set KERNEL "./vmlinuz"
        set KERNEL_INITRD "./initrd.gz"
        set KERNEL_CMDLINE "earlyprintk=serial console=ttyS0"
        set MEM {512M}
        set PCI_DEV1 {0:0,hostbridge}
        set PCI_DEV2 {31,lpc}
        set LPC_DEV {com1,stdio}
        set ACPI {-A}
        spawn #{bin}/hyperkit $ACPI -m $MEM -s $PCI_DEV1 -s $PCI_DEV2 -l $LPC_DEV -f kexec,$KERNEL,$KERNEL_INITRD,$KERNEL_CMDLINE
        set pid [exp_pid]
        set timeout 20
        expect {
          timeout { puts "FAIL boot"; exec kill -9 $pid; exit 1 }
          "\\r\\ntc@box:~$ "
        }
        send "sudo halt\\r\\n";
        expect {
          timeout { puts "FAIL shutdown"; exec kill -9 $pid; exit 1 }
          "reboot: System halted"
        }
        expect eof
        puts "\\nPASS"
      EOS
      system "expect", "test_hyperkit.exp"
    end
  end
end
