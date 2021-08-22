class Freeglut < Formula
  desc "Open-source alternative to the OpenGL Utility Toolkit (GLUT) library"
  homepage "https://freeglut.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/freeglut/freeglut/3.0.0/freeglut-3.0.0.tar.gz"
  sha256 "2a43be8515b01ea82bcfa17d29ae0d40bd128342f0930cd1f375f1ff999f76a2"



  depends_on "cmake" => :build
  depends_on :x11

  patch :DATA

  def install
    inreplace "src/x11/fg_main_x11.c", "CLOCK_MONOTONIC", "UNDEFINED_GIBBERISH"
    system "cmake", "-D", "FREEGLUT_BUILD_DEMOS:BOOL=OFF", "-D", "CMAKE_INSTALL_PREFIX:PATH=#{prefix}", "."
    system "make", "all"
    system "make", "install"
  end
end

__END__

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 28f8651..d1f6a86 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -220,6 +220,16 @@
 IF(FREEGLUT_GLES)
   ADD_DEFINITIONS(-DFREEGLUT_GLES)
   LIST(APPEND LIBS GLESv2 GLESv1_CM EGL)
+ELSEIF(APPLE)
+  # on OSX FindOpenGL uses framework version of OpenGL, but we need X11 version
+  FIND_PATH(GLX_INCLUDE_DIR GL/glx.h
+            PATHS /opt/X11/include /usr/X11/include /usr/X11R6/include)
+  FIND_LIBRARY(OPENGL_gl_LIBRARY GL
+               PATHS /opt/X11/lib /usr/X11/lib /usr/X11R6/lib)
+  FIND_LIBRARY(OPENGL_glu_LIBRARY GLU
+               PATHS /opt/X11/lib /usr/X11/lib /usr/X11R6/lib)
+  LIST(APPEND LIBS ${OPENGL_gl_LIBRARY})
+  INCLUDE_DIRECTORIES(${GLX_INCLUDE_DIR})
 ELSE()
   FIND_PACKAGE(OpenGL REQUIRED)
   LIST(APPEND LIBS ${OPENGL_gl_LIBRARY})
