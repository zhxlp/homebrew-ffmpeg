class GnuComplexity < Formula
  desc "Measures complexity of C source"
  homepage "https://www.gnu.org/software/complexity"
  url "https://ftp.gnu.org/gnu/complexity/complexity-1.10.tar.xz"
  mirror "https://ftpmirror.gnu.org/complexity/complexity-1.10.tar.xz"
  sha256 "6d378a3ef9d68938ada2610ce32f63292677d3b5c427983e8d72702167a22053"



  depends_on "autogen"
  depends_on "gcc" if MacOS.version == :mavericks

  # error: use of undeclared identifier '__noreturn__'
  fails_with :clang if MacOS.version == :mavericks

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      void free_table(uint32_t *page_dir) {
          // The last entry of the page directory is reserved. It points to the page
          // table itself.
          for (size_t i = 0; i < PAGE_TABLE_SIZE-2; ++i) {
              uint32_t *page_entry = (uint32_t*)GETADDRESS(page_dir[i]);
              for (size_t j = 0; j < PAGE_TABLE_SIZE; ++j) {
                  uintptr_t addr = (i<<20|j<<12);
                  if (addr == VIDEO_MEMORY_BEGIN ||
                          (addr >= KERNEL_START && addr < KERNEL_END)) {
                      continue;
                  }
                  if ((page_entry[j] & PAGE_PRESENT) == 1) {
                      free_frame(page_entry[j]);
                  }
              }
          }
          free_frame((page_frame_t)page_dir);
      }
    EOS
    system bin/"complexity", "-t", "3", "./test.c"
  end
end
