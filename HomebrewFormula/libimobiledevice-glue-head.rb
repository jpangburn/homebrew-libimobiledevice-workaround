class LibimobiledeviceGlueHead < Formula
  desc "Library of common code for libraries/tools in the libimobiledevice project"
  homepage "https://github.com/libimobiledevice/libimobiledevice-glue"
  head "https://github.com/libimobiledevice/libimobiledevice-glue.git"
  license "LGPL-2.1"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "libplist"
  conflicts_with "libimobiledevice-glue", because: "this is a hack to workaround libimobiledevice-glue not having their own Homebrew formula yet"

  def install
    system "./autogen.sh", *std_configure_args
    system "make", "install"
    print("\nTo finishing using this nasty hack, now do 'brew install --HEAD usbmuxd-HEAD' (or libimobiledevice-HEAD, etc)\n");
    print("Uninstall this hack if/when they get time to make an official libimobiledevice-glue formula\n");
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test libimobiledevice-glue-HEAD`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
