# Zhxlp Ffmpeg

## 环境

MacOS 10.12

## Install Brew

```bash
  export http_proxy=http://192.168.2.200:10809
  export https_proxy=http://192.168.2.200:10809
  export HOMEBREW_NO_AUTO_UPDATE=true
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Install homebrew-ffmpeg

```bash
cd /usr/local/Homebrew/Library/Taps/homebrew/homebrew-core
git clone https://github.com/zhxlp/homebrew-ffmpeg.git
mv homebrew-core homebrew-core.bak
ln -sf homebrew-ffmpeg homebrew-core
```

## Install FFmpeg

```bash
brew install -s -v -d sphinx-doc
# pip3 install Sphinx==1.8.4
brew install ffmpeg
```

## FFmpeg Static Lib

```
libSDL2.a
libaom.a
libass.a
libavcodec.a
libavdevice.a
libavfilter.a
libavformat.a
libavresample.a
libavutil.a
libbluray.a
libbz2.a
libcrypto.a
libexpat.a
libfontconfig.a
libfreetype.a
libgmp.a
libgnutls.a
libhogweed.a
libiconv.a
liblzma.a
libmp3lame.a
libnettle.a
libogg.a
libopencore-amrnb.a
libopencore-amrwb.a
libopenjp2.a
libopus.a
libpng.a
libpostproc.a
librtmp.a
librubberband.a
libsnappy.a
libsoxr.a
libspeex.a
libssl.a
libswresample.a
libswscale.a
libtasn1.a
libtesseract.a
libtheoradec.a
libtheoraenc.a
libunistring.a
libvorbis.a
libvorbisenc.a
libvpx.a
libx264.a
libx265.a
libxml2.a
libxvidcore.a
libz.a

```

LDFLAGS

```
-L./libav_darwin/lib -lswscale -lswresample -lpostproc -lavutil -lavresample -lavformat -lavfilter -lavdevice -lavcodec -lSDL2 -lrubberband -ltesseract -lass -lz -laom -lmp3lame -lopencore-amrnb -lopenjp2 -lopus -lspeex -ltheoraenc -ltheoradec -logg -lvorbis -lvorbisenc -lx264 -lx265 -lfontconfig -lfreetype -lbz2 -lbluray -lgnutls -lrtmp -lssl -lcrypto -lvpx -liconv -llzma -lopencore-amrwb -lsnappy -lsoxr -lxml2 -lgmp -lunistring -lhogweed -lnettle -ltasn1 -lpng -lexpat -lxvidcore -lstdc++ -framework Foundation -framework AudioToolbox -framework CoreAudio -framework AVFoundation -framework CoreVideo -framework CoreMedia -framework CoreGraphics -framework OpenGL  -framework CoreImage -framework AppKit -framework VideoToolbox -framework CoreFoundation -framework CoreServices

```
