class Cvs2svn < Formula
  desc "Tool for converting from CVS to Subversion"
  homepage "http://cvs2svn.tigris.org/"
  url "http://cvs2svn.tigris.org/files/documents/1462/49543/cvs2svn-2.5.0.tar.gz"
  sha256 "6409d118730722f439760d41c08a5bfd05e5d3ff4a666050741e4a5dc2076aea"



  depends_on "python@2" # does not support Python 3

  def install
    system "python", "setup.py", "install", "--prefix=#{prefix}"
    system "make", "man"
    man1.install gzip("cvs2svn.1", "cvs2git.1", "cvs2bzr.1")
    prefix.install %w[ BUGS COMMITTERS HACKING
                       cvs2bzr-example.options
                       cvs2git-example.options
                       cvs2hg-example.options
                       cvs2svn-example.options contrib ]
    doc.install Dir["{doc,www}/*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cvs2svn --version")
  end
end
