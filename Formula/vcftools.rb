class Vcftools < Formula
  desc "Tools for working with VCF files"
  homepage "https://vcftools.github.io/"
  url "https://github.com/vcftools/vcftools/releases/download/v0.1.16/vcftools-0.1.16.tar.gz"
  sha256 "dbfc774383c106b85043daa2c42568816aa6a7b4e6abc965eeea6c47dde914e3"



  depends_on "pkg-config" => :build
  depends_on "htslib"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}",
                          "--with-pmdir=lib/perl5/site_perl"
    system "make", "install"

    bin.env_script_all_files(libexec/"bin", :PERL5LIB => lib/"perl5/site_perl")
  end

  test do
    (testpath/"test.vcf").write <<~EOS
      ##fileformat=VCFv4.0
      #CHROM	POS	ID	REF	ALT	QUAL	FILTER	INFO
      1	1	.	A	C	10	PASS	.
    EOS
    system "#{bin}/vcf-validator", "test.vcf"
  end
end
