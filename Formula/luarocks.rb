class Luarocks < Formula
  desc "Package manager for the Lua programming language"
  homepage "https://luarocks.org/"
  url "https://luarocks.org/releases/luarocks-3.0.1.tar.gz"
  sha256 "b989c4b60d6c9edcd65169e5e42fcffbd39cdbebe6b138fa5aea45102f8d9ec0"



  depends_on "lua@5.1" => :test
  depends_on "lua"

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--sysconfdir=#{etc}",
                          "--rocks-tree=#{HOMEBREW_PREFIX}"
    system "make", "install"
  end

  def caveats; <<~EOS
    LuaRocks supports multiple versions of Lua. By default it is configured
    to use Lua5.3, but you can require it to use another version at runtime
    with the `--lua-dir` flag, like this:

      luarocks --lua-dir=#{Formula["lua@5.1"].opt_prefix} install say
  EOS
  end

  test do
    ENV["LUA_PATH"] = "#{testpath}/share/lua/5.3/?.lua"
    ENV["LUA_CPATH"] = "#{testpath}/lib/lua/5.3/?.so"

    (testpath/"lfs_53test.lua").write <<~EOS
      require("lfs")
      print(lfs.currentdir())
    EOS

    system "#{bin}/luarocks", "--tree=#{testpath}", "install", "luafilesystem"
    system "lua", "-e", "require('lfs')"
    assert_match testpath.to_s, shell_output("lua lfs_53test.lua")

    ENV["LUA_PATH"] = "#{testpath}/share/lua/5.1/?.lua"
    ENV["LUA_CPATH"] = "#{testpath}/lib/lua/5.1/?.so"

    (testpath/"lfs_51test.lua").write <<~EOS
      require("lfs")
      lfs.mkdir("blank_space")
    EOS

    system "#{bin}/luarocks", "--tree=#{testpath}",
                              "--lua-dir=#{Formula["lua@5.1"].opt_prefix}",
                              "install", "luafilesystem"
    system "lua5.1", "-e", "require('lfs')"
    system "lua5.1", "lfs_51test.lua"
    assert_predicate testpath/"blank_space", :directory?,
      "Luafilesystem failed to create the expected directory"
  end
end
