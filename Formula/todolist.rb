class Todolist < Formula
  desc "Very fast, simple task manager for the command-line, based upon GTD"
  homepage "http://todolist.site"
  url "https://github.com/gammons/todolist/archive/v0.8.1.tar.gz"
  sha256 "b3eaf0a06ef212396b6b45990cf8d6a8451341b6e48d9be577bb7e457a6b4edd"



  depends_on "go" => :build
  depends_on "govendor" => :build

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/gammons/").mkpath
    ln_s buildpath, buildpath/"src/github.com/gammons/todolist"
    system "go", "build", "-o", bin/"todolist", "./src/github.com/gammons/todolist"
  end

  test do
    system bin/"todolist", "init"
    assert_predicate testpath/".todos.json", :exist?
    add_task = shell_output("#{bin}/todolist add learn the Tango")
    assert_match /Todo.* added/, add_task
  end
end
