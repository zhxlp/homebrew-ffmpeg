class Einstein < Formula
  desc "Remake of the old DOS game Sherlock"
  homepage "https://web.archive.org/web/20120621005109/games.flowix.com/en/index.html"
  url "https://web.archive.org/web/20120621005109/games.flowix.com/files/einstein/einstein-2.0-src.tar.gz"
  sha256 "0f2d1c7d46d36f27a856b98cd4bbb95813970c8e803444772be7bd9bec45a548"



  depends_on "sdl"
  depends_on "sdl_mixer"
  depends_on "sdl_ttf"

  # Fixes a cast error on compilation
  patch :p0, :DATA

  def install
    system "make"

    bin.install "einstein"
    (pkgshare/"res").install "einstein.res"
  end
end

__END__
--- formatter.cpp
+++ formatter.cpp
@@ -58,7 +58,7 @@ Formatter::Formatter(unsigned char *data, int offset)
             if ((c.type == INT_ARG) || (c.type == STRING_ARG) ||
                     (c.type == FLOAT_ARG) || (c.type == DOUBLE_ARG))
             {
-                int no = (int)c.data;
+                int no = *((int*)(&c.data));
                 args[no - 1] = c.type;
             }
         }
@@ -135,7 +135,7 @@ std::wstring Formatter::format(std::vector<ArgValue*> &argValues) const

             case STRING_ARG:
             case INT_ARG:
-                no = (int)cmd->data - 1;
+                no = *((int*)(&cmd->data)) - 1;
                 if (no < (int)argValues.size())
                     s += argValues[no]->format(cmd);
                 break;
--- main.cpp
+++ main.cpp
@@ -61,13 +61,9 @@ static void loadResources(const std::wstring &selfPath)
 #ifdef WIN32
     dirs.push_back(getStorage()->get(L"path", L"") + L"\\res");
 #else
-#ifdef __APPLE__
-    dirs.push_back(getResourcesPath(selfPath));
-#else
     dirs.push_back(PREFIX L"/share/einstein/res");
     dirs.push_back(fromMbcs(getenv("HOME")) + L"/.einstein/res");
 #endif
-#endif
     dirs.push_back(L"res");
     dirs.push_back(L".");
     resources = new ResourcesCollection(dirs);
