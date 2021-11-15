class LibimobiledeviceHead < Formula
  desc "Library to communicate with iOS devices natively"
  homepage "https://www.libimobiledevice.org/"
  head "https://github.com/libimobiledevice/libimobiledevice.git"
  license "LGPL-2.1"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "libplist"
  depends_on "libtasn1"
  depends_on "libusbmuxd-HEAD"
  depends_on "openssl@1.1"
  depends_on "libimobiledevice-glue-HEAD"

  conflicts_with "libimobiledevice", because: "this is a hack to workaround libimobiledevice-glue not having their own Homebrew formula yet to install HEAD version of this project"

  def install
    system "./autogen.sh"
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}",
                          # As long as libplist builds without Cython
                          # bindings, libimobiledevice must as well.
                          "--without-cython",
                          "--enable-debug-code"
    system "make", "install"
  end

  test do
    system "#{bin}/idevicedate", "--help"
  end
end
