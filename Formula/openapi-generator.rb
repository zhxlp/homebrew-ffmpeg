class OpenapiGenerator < Formula
  desc "Generate clients, server & docs from an OpenAPI spec (v2, v3)"
  homepage "https://openapi-generator.tech/"
  url "https://search.maven.org/remotecontent?filepath=org/openapitools/openapi-generator-cli/3.3.4/openapi-generator-cli-3.3.4.jar"
  sha256 "24cb04939110cffcdd7062d2f50c6f61159dc3e0ca3b8aecbae6ade53ad3dc8c"

  head do
    url "https://github.com/OpenAPITools/openapi-generator.git"

    depends_on "maven" => :build
  end

  bottle :unneeded

  depends_on "java" => "1.8+"

  def install
    # Need to set JAVA_HOME manually since maven overrides 1.8 with 1.7+
    # cmd = Language::Java.java_home_cmd("1.8")
    # ENV["JAVA_HOME"] = Utils.popen_read(cmd).chomp
    ENV["JAVA_HOME"] = "/usr/local/Cellar/java/1.8/libexec/openjdk.jdk/Contents/Home/"

    if build.head?
      system "mvn", "clean", "package", "-Dmaven.javadoc.skip=true"
      libexec.install "modules/openapi-generator-cli/target/openapi-generator-cli.jar"
      bin.write_jar_script libexec/"openapi-generator-cli.jar", "openapi-generator", "$JAVA_OPTS"
    else
      libexec.install "openapi-generator-cli-#{version}.jar"
      bin.write_jar_script libexec/"openapi-generator-cli-#{version}.jar", "openapi-generator", "$JAVA_OPTS"
    end
  end

  test do
    (testpath/"minimal.yaml").write <<~EOS
      ---
      swagger: '2.0'
      info:
        version: 0.0.0
        title: Simple API
      host: localhost
      basePath: /v2
      schemes:
        - http
      paths:
        /:
          get:
            operationId: test_operation
            responses:
              200:
                description: OK
    EOS
    system bin/"openapi-generator", "generate", "-i", "minimal.yaml", "-g", "openapi"
  end
end
