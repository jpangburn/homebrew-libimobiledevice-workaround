class IosWebkitDebugProxyHead < Formula
  desc "DevTools proxy for iOS devices"
  homepage "https://github.com/google/ios-webkit-debug-proxy"
  license "BSD-3-Clause"
  head "https://github.com/google/ios-webkit-debug-proxy.git"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "libimobiledevice-head"
  depends_on "libplist"
  depends_on "openssl@1.1"

  conflicts_with "ios-webkit-debug-proxy", because: "this is a hack to workaround libimobiledevice-glue not having their own Homebrew formula yet to install HEAD version of this project"

  def install
    system "./autogen.sh"
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    base_port = free_port
    (testpath/"config.csv").write <<~EOS
      null:#{base_port},:#{base_port + 1}-#{base_port + 101}
    EOS

    fork do
      exec "#{bin}/ios_webkit_debug_proxy", "-c", testpath/"config.csv"
    end

    sleep(2)
    assert_match "iOS Devices:", shell_output("curl localhost:#{base_port}")
  end
end
