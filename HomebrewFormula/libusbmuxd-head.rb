# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class LibusbmuxdHead < Formula
  desc "USB multiplexor library for iOS devices"
  homepage "https://www.libimobiledevice.org/"
  license all_of: ["GPL-2.0-or-later", "LGPL-2.1-or-later"]
  head "https://github.com/libimobiledevice/libusbmuxd.git"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "libplist"
  depends_on "libusb"
  depends_on "libimobiledevice-glue-HEAD"

  conflicts_with "libusbmuxd", because: "this is a hack to workaround libimobiledevice-glue not having their own Homebrew formula yet to install HEAD version of this project"

  uses_from_macos "netcat" => :test

  def install
    system "./autogen.sh"
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    source = free_port
    dest = free_port
    fork do
      exec bin/"iproxy", "-s", "localhost", "#{source}:#{dest}"
    end

    sleep(2)
    system "nc", "-z", "localhost", source
  end
end
