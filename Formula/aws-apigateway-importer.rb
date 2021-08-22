class AwsApigatewayImporter < Formula
  desc "AWS API Gateway Importer"
  homepage "https://github.com/amazon-archives/aws-apigateway-importer"
  url "https://github.com/amazon-archives/aws-apigateway-importer/archive/aws-apigateway-importer-1.0.1.tar.gz"
  sha256 "8371e3fb1b6333cd50a76fdcdc1280ee8e489aec4bf9a1869325f9b8ebb73b54"
  revision 1



  depends_on "maven" => :build
  depends_on :java => "1.8"

  # Pin aws-sdk-java-core for JSONObject compatibility
  patch do
    url "https://github.com/amazon-archives/aws-apigateway-importer/commit/660e3ce.diff?full_index=1"
    sha256 "6ff63c504b906e1fb6d0f2a9772761edeef3b37b3dca1e48bba72432d863a852"
  end

  def install
    system "mvn", "assembly:assembly"
    libexec.install "target/aws-apigateway-importer-1.0.1-jar-with-dependencies.jar"
    bin.write_jar_script libexec/"aws-apigateway-importer-1.0.1-jar-with-dependencies.jar", "aws-api-import"
  end

  test do
    assert_match(/^Usage:\s+aws-api-import/, shell_output("#{bin}/aws-api-import --help"))
  end
end
