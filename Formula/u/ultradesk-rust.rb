class UltradeskRust < Formula
  desc "Remote desktop client and host compatible with UltraViewer"
  homepage "https://github.com/dtrh95/ultradesk"
  url "https://github.com/dtrh95/ultradesk/archive/refs/tags/v1.0.6.tar.gz"
  sha256 "0332a77b6b954c8b363bcfd70b3365aa412388db0db432881739f5c6d28c8765"
  license "MIT"
  head "https://github.com/dtrh95/ultradesk.git", branch: "main"

  depends_on "rust" => :build

  on_linux do
    depends_on "pkgconf" => :build
    depends_on "openssl@3"
  end

  def install
    args = OS.mac? ? [] : ["--no-default-features"]
    system "cargo", "install", *std_cargo_args, *args
    pkgshare.install "viewer.html", "8bit.dat"
  end

  test do
    input = '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{}}'
    output = pipe_output("#{bin}/ultradesk-rust mcp", "#{input}\n", 0)
    assert_match "\"name\":\"ultradesk-mcp\"", output
    assert_match "\"version\":\"#{version}\"", output
  end
end
