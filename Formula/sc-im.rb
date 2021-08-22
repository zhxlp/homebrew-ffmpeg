class ScIm < Formula
  desc "Spreadsheet program for the terminal, using ncurses"
  homepage "https://github.com/andmarti1424/sc-im"
  url "https://github.com/andmarti1424/sc-im/archive/v0.7.0.tar.gz"
  sha256 "87225918cb6f52bbc068ee6b12eaf176c7c55ba9739b29ca08cb9b6699141cad"
  head "https://github.com/andmarti1424/sc-im.git", :branch => "freeze"



  depends_on "ncurses"

  def install
    cd "src" do
      system "make", "prefix=#{prefix}"
      system "make", "prefix=#{prefix}", "install"
    end
  end

  test do
    input = <<~EOS
      let A1=1+1
      getnum A1
    EOS
    output = pipe_output(
      "#{bin}/scim --nocurses --quit_afterload 2>/dev/null", input
    )
    assert_equal "2", output.lines.last.chomp
  end
end
