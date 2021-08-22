class Neatvi < Formula
  desc "ex/vi clone for editing bidirectional utf-8 text"
  homepage "https://repo.or.cz/neatvi.git"
  url "https://repo.or.cz/neatvi.git",
      :tag      => "06",
      :revision => "5ed4bbc7f12686bb480ab8b2b05c94e12b1c71d8"
  head "https://repo.or.cz/neatvi.git"



  def install
    system "make"
    bin.install "vi" => "neatvi"
  end

  test do
    pipe_output("#{bin}/neatvi", ":q\n")
  end
end
