class Lsyncd < Formula
  desc "Synchronize local directories with remote targets"
  homepage "https://github.com/axkibe/lsyncd"
  url "https://github.com/axkibe/lsyncd/archive/release-2.2.3.tar.gz"
  sha256 "7bcd0f4ae126040bb078c482ff856c87e61c22472c23fa3071798dcb1dc388dd"



  depends_on "cmake" => :build
  depends_on "lua"

  xnu_headers = {
    "10.7"    => ["xnu-1699.22.73.tar.gz",  "c9d24560af543e6099b6248bdbcef3581e7ba4af3afd92974719f7c5a8db5bd2"],
    "10.7.1"  => ["xnu-1699.22.81.tar.gz",  "b1422aadf0d3842f3c97e61178adfddb6596e67ba1d877da7f11e2f455fa8dec"],
    "10.7.2"  => ["xnu-1699.24.8.tar.gz",   "4268ce69799db51f1b48e400b6fa6a7041b266a1a5404034398aa51b7084b269"],
    "10.7.3"  => ["xnu-1699.24.23.tar.gz",  "f91a2e8128e220c7ea21ff5c0b61cf76b2afcae83f057d2116837272fd46bead"],
    "10.7.4"  => ["xnu-1699.26.8.tar.gz",   "76f0e6e703218b3b1620b29b7fabb5eb177c990af20711a90085a5a6afc54022"],
    "10.7.5"  => ["xnu-1699.32.7.tar.gz",   "2163816aae990675d8f45cdced4b680bb112fb7a600eb0063af2c2bc2ea15e15"],
    "10.8"    => ["xnu-2050.7.9.tar.gz",    "25c8fc346d1c209f6d20b456dcb256f1e829e844f67b262c090caf088559f4b1"],
    "10.8.1"  => ["xnu-2050.9.2.tar.gz",    "f342179c625413ae3a74fc1a5747fc555c1353cfef6259c595626469744a6405"],
    "10.8.2"  => ["xnu-2050.18.24.tar.gz",  "5d018b33efd9eebb05142958432b9a5058febe04a3b92ba5a16a285490a83445"],
    "10.8.3"  => ["xnu-2050.22.13.tar.gz",  "54011448f0cbb84792146657f4f5f8f64beca52e63bd0eb6028aadedf153a4d6"],
    "10.8.4"  => ["xnu-2050.24.15.tar.gz",  "24e6dc5d98d8f2be450832ea9cfaf2fc85c090422e5b89b24c2a80f0d2957a04"],
    "10.8.5"  => ["xnu-2050.48.11.tar.gz",  "454203188d19a368f850f335a6b4c8fbfc383e929116b2b06e63d8365ccd207e"],
    "10.9"    => ["xnu-2422.1.72.tar.gz",   "fbefe23943d0c4c12b3d7abd3f304224176f269b19ef6ad801314bc69cf773db"],
    "10.9.1"  => ["xnu-2422.1.72.tar.gz",   "fbefe23943d0c4c12b3d7abd3f304224176f269b19ef6ad801314bc69cf773db"],
    "10.9.2"  => ["xnu-2422.90.20.tar.gz",  "7bf3c6bc2f10b99e57b996631a7747b79d1e1684df719196db1e5c98a5585c23"],
    "10.9.3"  => ["xnu-2422.100.13.tar.gz", "0deb3a323804a18e23261b1f770a7b85b6329213cb77f525d5a2663e8961d87a"],
    "10.9.4"  => ["xnu-2422.110.17.tar.gz", "0b973913648d5773367f264002f7832bd01510687fa55a28ef1438c86affa141"],
    "10.9.5"  => ["xnu-2422.115.4.tar.gz",  "1a505922bbf232a616a7398e17eff4477fb0621a6c046ff802a2c7b7bf2b5ceb"],
    "10.10"   => ["xnu-2782.1.97.tar.gz",   "18fd93155c53fa66c48c2c876313311bba55cff260ea10e7b67dd7ed1f4b945c"],
    "10.10.1" => ["xnu-2782.1.97.tar.gz",   "18fd93155c53fa66c48c2c876313311bba55cff260ea10e7b67dd7ed1f4b945c"],
    "10.10.2" => ["xnu-2782.10.72.tar.gz",  "0725dfc77ce245e37b57d226445217c17d0a7750db099d3ca69a4ad1c7f39356"],
    "10.10.3" => ["xnu-2782.20.48.tar.gz",  "d1d7cfdf282b6b651415d5adb7f591f3d7ee0e0ccdd29db664c0ec3f9f827146"],
    "10.10.4" => ["xnu-2782.30.5.tar.gz",   "16fbd88fb5833fdfb6d8169b7c330d344c12b6a644678a1eb68f27c318b8811d"],
    "10.10.5" => ["xnu-2782.40.9.tar.gz",   "f9f2524124edebe81bb1ead2f69c3daeed1f37641aef68ac4df5bcffd2ab0898"],
    "10.11"   => ["xnu-3247.1.106.tar.gz",  "660f8f107d284fe797675b0a266c63016876aa5bb4add99d88ffb9cd9001d84f"],
    "10.11.1" => ["xnu-3247.10.11.tar.gz",  "66ff554039e3b8351fdb2103c4dfb6bf8015c6f9a219f70c057b839cb10b1640"],
    "10.11.2" => ["xnu-3248.20.55.tar.gz",  "10c3acf0da74d6f4684d6a870b425546fc9c9dcb9c39541556f47cba2440a2ab"],
    "10.11.3" => ["xnu-3248.30.4.tar.gz",   "106a8a3a9e01bd73b06298f81b397fe3d772428e0a650edb24b340315a4d0e84"],
    "10.11.4" => ["xnu-3248.40.184.tar.gz", "a9e1b03ae9cde203f83602260ea1994822cb4e38c81b99e74797a124f6cd10ab"],
    "10.11.5" => ["xnu-3248.50.21.tar.gz",  "e1daa3666c7cdf35d7d320a0b0dae8b7d03ea35c7383ea681371e0543fb5d4b5"],
    "10.11.6" => ["xnu-3248.60.10.tar.gz",  "295b69cee59f2a7419eab3d95744595fa8cd614716fb6ddc958b61dc088e1f7a"],
    "10.12"   => ["xnu-3789.1.32.tar.gz",   "5bff9606bf32d9ae11d964d8eb280ed9543e4e4fef1cc394d272d7b6ce3f1e55"],
    "10.12.1" => ["xnu-3789.21.4.tar.gz",   "0e866d90f1b966ccb466ea0c7d4dd8f1e32d40132bbac5c21a857fb6c2522119"],
    "10.12.2" => ["xnu-3789.31.2.tar.gz",   "768087e43fd16e4ce93862070a91f4b8b47c8d27640b4c35d68bb49a2ca3e4bd"],
    "10.12.3" => ["xnu-3789.41.3.tar.gz",   "910a8a5d69330d635a5a716ae1d70a2c503c1700fba7612d3ce604feee4eb3dd"],
    "10.12.4" => ["xnu-3789.51.2.tar.gz",   "126c377a9f0b6364d6eb7618cb8ab863deab045c3d06338632f887e7e99261fa"],
    "10.12.5" => ["xnu-3789.60.24.tar.gz",  "00e0a95c0ba451863397680e9316dc579cbfacb114264cee417bceecaa256b22"],
    "10.12.6" => ["xnu-3789.70.16.tar.gz",  "e5b912036a7ceca92e7ada44ef4b264de928bd247a7c02c50604fd8f4f044bea"],
    "10.13"   => ["xnu-4570.1.46.tar.gz",   "18c418c906d08acc7db471d0783269f50aeae73fff0aae0b61c848c4c926c767"],
    "10.13.1" => ["xnu-4570.20.62.tar.gz",  "4968ae345a83d7aca3a8da65bf09bdc637e2eefbc236f7931c38abb879fe05df"],
    "10.13.2" => ["xnu-4570.31.3.tar.gz",   "1c364646d001f1a6eee80fa71f746b1142121203eabd808f1eab18317ade576c"],
    "10.13.3" => ["xnu-4570.41.2.tar.gz",   "e26ea5451126278d22dff7399b956c0fd1fbbdca82d90d4bb105b1ad0731162d"],
    "10.13.4" => ["xnu-4570.41.2.tar.gz",   "e26ea5451126278d22dff7399b956c0fd1fbbdca82d90d4bb105b1ad0731162d"],
    "10.13.5" => ["xnu-4570.41.2.tar.gz",   "e26ea5451126278d22dff7399b956c0fd1fbbdca82d90d4bb105b1ad0731162d"],
    "10.13.6" => ["xnu-4570.41.2.tar.gz",   "e26ea5451126278d22dff7399b956c0fd1fbbdca82d90d4bb105b1ad0731162d"],
    "10.14"   => ["xnu-4570.41.2.tar.gz",   "e26ea5451126278d22dff7399b956c0fd1fbbdca82d90d4bb105b1ad0731162d"],
  }

  if xnu_headers.key? MacOS.full_version
    tarball, checksum = xnu_headers.fetch(MacOS.full_version)
    resource "xnu" do
      url "https://opensource.apple.com/tarballs/xnu/#{tarball}"
      sha256 checksum
    end
  end

  def install
    inreplace "CMakeLists.txt", "DESTINATION man", "DESTINATION share/man/man1"
    resource("xnu").stage buildpath/"xnu"
    system "cmake", ".", "-DWITH_INOTIFY=OFF", "-DWITH_FSEVENTS=ON",
                         "-DXNU_DIR=#{buildpath}/xnu", *std_cmake_args
    system "make", "install"
  end

  test do
    system bin/"lsyncd", "--version"
  end
end
