class Euca2ools < Formula
  include Language::Python::Virtualenv

  desc "Eucalyptus client API tools-works with Amazon EC2 and IAM"
  homepage "https://github.com/eucalyptus/euca2ools"
  url "https://downloads.eucalyptus.com/software/euca2ools/3.4/source/euca2ools-3.4.1.tar.xz"
  mirror "https://src.fedoraproject.org/lookaside/extras/euca2ools/euca2ools-3.4.1.tar.xz/sha512/5f7a2238f2475c5d8422069446292cce841bfe33b5c4a65f4a209e15e3d0e3cc6be14743aca086fc1b14da629c0e9860411f50826fe21f3dfc9fd0539af34716/euca2ools-3.4.1.tar.xz"
  sha256 "af2027306cf7829ee512c02c1160e96a8f9c152b77f6eb408bf3dee4d4bb551d"
  head "https://github.com/eucalyptus/euca2ools.git"



  depends_on "python@2" # does not support Python 3

  resource "requestbuilder" do
    url "https://files.pythonhosted.org/packages/ac/b5/8b1c6c102760785ce22a08f32fb6fc8c745445ed8f1f9195d2517c79511c/requestbuilder-0.7.1.tar.gz"
    sha256 "84ed99ab55e6a549686af32328b2b15a1f5416800ee23b65346edd7a84706089"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/b6/61/7b374462d5b6b1d824977182db287758d549d8680444bad8d530195acba2/requests-2.12.5.tar.gz"
    sha256 "d902a54f08d086a7cc6e58c20e2bb225b1ae82c19c35e5925269ee94fb9fce00"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/b3/b2/238e2590826bfdd113244a40d9d3eb26918bd798fc187e2360a8367068db/six-1.10.0.tar.gz"
    sha256 "105f8d68616f8248e24bf0e9372ef04d3cc10104f1980f54d57b2ce73a5ad56a"
  end

  resource "lxml" do
    url "https://files.pythonhosted.org/packages/66/45/f11fc376f784c6f2e77ffc7a9d02374ff3ceb07ede8c56f918939409577c/lxml-3.7.2.tar.gz"
    sha256 "59d9176360dbc3919e9d4bfca85c1ca64ab4f4ee00e6f119d7150ba887e3410a"
  end

  resource "PyYAML" do
    url "https://files.pythonhosted.org/packages/4a/85/db5a2df477072b2902b0eb892feb37d88ac635d36245a72a6a69b23b383a/PyYAML-3.12.tar.gz"
    sha256 "592766c6303207a20efc445587778322d7f73b161bd994f227adaa341ba212ab"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    system "#{bin}/euca-version"
    system "#{bin}/euca-describe-instances", "--help"
  end
end
