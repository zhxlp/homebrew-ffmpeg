class Arangodb < Formula
  desc "The Multi-Model NoSQL Database"
  homepage "https://www.arangodb.com/"
  url "https://download.arangodb.com/Source/ArangoDB-3.4.0.tar.gz"
  sha256 "5e45fa2f5eff8420a2e3e083535663a21ab06bc66fa29857d6cd4e36ed4c4aff"
  head "https://github.com/arangodb/arangodb.git", :branch => "unstable"



  depends_on "cmake" => :build
  depends_on "go" => :build
  depends_on :macos => :yosemite
  depends_on "openssl"

  fails_with :gcc do
    build 820
    cause "Generates incorrect code"
  end

  def install
    ENV.cxx11

    mkdir "build" do
      args = std_cmake_args + %W[
        -DHOMEBREW=ON
        -DUSE_OPTIMIZE_FOR_ARCHITECTURE=OFF
        -DASM_OPTIMIZATIONS=OFF
        -DCMAKE_INSTALL_DATADIR=#{share}
        -DCMAKE_INSTALL_DATAROOTDIR=#{share}
        -DCMAKE_INSTALL_SYSCONFDIR=#{etc}
        -DCMAKE_INSTALL_LOCALSTATEDIR=#{var}
      ]

      if ENV.compiler == "gcc-6"
        ENV.append "V8_CXXFLAGS", "-O3 -g -fno-delete-null-pointer-checks"
      end

      system "cmake", "..", *args
      system "make", "install"

      %w[arangod arango-dfdb arangosh foxx-manager].each do |f|
        inreplace etc/"arangodb3/#{f}.conf", pkgshare, opt_pkgshare
      end
    end
  end

  def post_install
    (var/"lib/arangodb3").mkpath
    (var/"log/arangodb3").mkpath
  end

  def caveats
    s = <<~EOS
      An empty password has been set. Please change it by executing
        #{opt_sbin}/arango-secure-installation
    EOS

    s
  end

  plist_options :manual => "#{HOMEBREW_PREFIX}/opt/arangodb/sbin/arangod"

  def plist; <<~EOS
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        <key>KeepAlive</key>
        <true/>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>Program</key>
        <string>#{opt_sbin}/arangod</string>
        <key>RunAtLoad</key>
        <true/>
      </dict>
    </plist>
  EOS
  end

  test do
    testcase = "require('@arangodb').print('it works!')"
    output = shell_output("#{bin}/arangosh --server.password \"\" --javascript.execute-string \"#{testcase}\"")
    assert_equal "it works!", output.chomp
  end
end
