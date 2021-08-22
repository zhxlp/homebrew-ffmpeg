class AuroraCli < Formula
  desc "Apache Aurora Scheduler Client"
  homepage "https://aurora.apache.org"
  url "https://archive.apache.org/dist//aurora/0.21.0/apache-aurora-0.21.0.tar.gz"
  sha256 "4b608e5199ae72c83b0bc97569de5ed2c58d73a709f6906c3664154144438b65"



  depends_on "python"

  def install
    # No pants yet for Mojave, so we force High Sierra binaries there
    ENV["PANTS_BINARIES_PATH_BY_ID"] = "{('darwin','15'):('mac','10.11'),('darwin','16'):('mac','10.12'),('darwin','17'):('mac','10.13'),('darwin','18'):('mac','10.13')}"

    system "./pants", "binary", "src/main/python/apache/aurora/kerberos:kaurora"
    system "./pants", "binary", "src/main/python/apache/aurora/kerberos:kaurora_admin"
    bin.install "dist/kaurora.pex" => "aurora"
    bin.install "dist/kaurora_admin.pex" => "aurora_admin"
  end

  test do
    ENV["AURORA_CONFIG_ROOT"] = "#{testpath}/"
    (testpath/"clusters.json").write <<~EOS
      [{
        "name": "devcluster",
        "slave_root": "/tmp/mesos/",
        "zk": "172.16.64.185",
        "scheduler_zk_path": "/aurora/scheduler",
        "auth_mechanism": "UNAUTHENTICATED"
      }]
    EOS
    system "#{bin}/aurora_admin", "get_cluster_config", "devcluster"
  end
end
