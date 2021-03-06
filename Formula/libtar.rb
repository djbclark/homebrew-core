class Libtar < Formula
  desc "C library for manipulating POSIX tar files"
  homepage "http://repo.or.cz/w/libtar.git"
  url "http://repo.or.cz/libtar.git",
      :tag => "v1.2.20",
      :revision => "0907a9034eaf2a57e8e4a9439f793f3f05d446cd"

  bottle do
    cellar :any
    rebuild 2
    sha256 "a263cfaa1499f0c82902009964df0a310e7841ddff29409c67ede0a79157c31e" => :high_sierra
    sha256 "68bdebde24477a815ea03289878ad57e8a1f719b417bef430bf477c2d760cad7" => :sierra
    sha256 "018f1c9897f52b783878db67db39a5933a4863a3f9dedc2af9b6bf13f2161957" => :el_capitan
    sha256 "d8d138fb4c1cf8c33aaaf8633cd748e9a423e84f1df886ae1842d4816b1f34a0" => :yosemite
    sha256 "b8eb40cc1715243eb0ff85eddd2a5f5546e19ca7278ce30b08bd8e1bd3f0682f" => :mavericks
    sha256 "895b12d04e1cda40eb0458d3125a534aa38daed594ff3f68fd65a8e3f5bc86f0" => :x86_64_linux # glibc 2.19
    sha256 "7e79320f86f0fc61f80a041e48aafacc9148403b124dd0543b78c84bdf1b3384" => :mountain_lion
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def install
    system "autoreconf", "--force", "--install"
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}"
    system "make", "install"
  end

  test do
    (testpath/"homebrew.txt").write "This is a simple example"
    system "tar", "-cvf", "test.tar", "homebrew.txt"
    rm "homebrew.txt"
    refute_predicate testpath/"homebrew.txt", :exist?
    assert_predicate testpath/"test.tar", :exist?

    system bin/"libtar", "-x", "test.tar"
    assert_predicate testpath/"homebrew.txt", :exist?
  end
end
