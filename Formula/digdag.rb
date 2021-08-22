class Digdag < Formula
  desc "Workload Automation System"
  homepage "https://www.digdag.io/"
  url "https://dl.digdag.io/digdag-0.9.32.jar"
  sha256 "e2fd9f50110177cced17f92644e44ba5f509f09c30c4161dd5b9c4035d290995"

  bottle :unneeded

  depends_on :java => "1.8+"

  def install
    libexec.install "digdag-#{version}.jar" => "digdag.jar"

    # Create a wrapper script to support OS X 10.9.
    (bin/"digdag").write <<~EOS
      #!/bin/bash
      exec /bin/bash "#{libexec}/digdag.jar" "$@"
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/digdag --version")
  end
end
