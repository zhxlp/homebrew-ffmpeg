class Texapp < Formula
  desc "App.net client based on TTYtter"
  homepage "https://www.floodgap.com/software/texapp/"
  url "https://www.floodgap.com/software/texapp/dist0/0.6.11.txt"
  sha256 "03c3d5475dfb7877000ce238d342023aeab3d44f7bac4feadc475e501aa06051"



  def install
    bin.install "#{version}.txt" => "texapp"
  end

  test do
    assert_match "trying to find cURL ...", pipe_output("#{bin}/texapp", "^C")
  end
end
