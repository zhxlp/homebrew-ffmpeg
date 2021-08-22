class Repo < Formula
  desc "Repository tool for Android development"
  homepage "https://source.android.com/source/developing.html"
  url "https://gerrit.googlesource.com/git-repo.git",
      :tag      => "v1.13.2",
      :revision => "13f323b2c221db4e69e3f5a671455954b65f1fb3"
  version_scheme 1

  bottle :unneeded

  def install
    bin.install "repo"
    doc.install (buildpath/"docs").children
  end

  test do
    assert_match "usage:", shell_output("#{bin}/repo help 2>&1", 1)
  end
end
