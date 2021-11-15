class IdeviceinstallerHead < Formula
  desc "Tool for managing apps on iOS devices"
  homepage "https://www.libimobiledevice.org/"
  head "https://github.com/libimobiledevice/ideviceinstaller.git"
  license "GPL-2.0"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "libimobiledevice-HEAD"
  depends_on "libplist"
  depends_on "libzip"
  depends_on "libimobiledevice-glue-HEAD"

  conflicts_with "ideviceinstaller", because: "this is a hack to workaround libimobiledevice-glue not having their own Homebrew formula yet to install HEAD version of this project"

  def install
    system "./autogen.sh"
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/ideviceinstaller --help |grep -q ^Usage"
  end
end
