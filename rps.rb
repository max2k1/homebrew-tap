require "language/go"

class Rps < Formula
  desc "Measure rows-per-second rate by reading access.logs through pipe"
  homepage "https://github.com/max2k1/rps"
  url "https://github.com/max2k1/rps/archive/0.0-5.tar.gz"
  version "0.0-5"
  sha256 "b1519c8bcd895160c92972f01b0d36f6ea8128b91a0a7fb5acfd5646079d71fc"

  head "https://github.com/max2k1/rps.git"

  depends_on "go" => :build

  go_resource "github.com/max2k1/render_number" do
    url "https://github.com/max2k1/render_number.git"
  end

  def install
    mkdir_p buildpath/"src/github.com/max2k1"
    ln_s buildpath, buildpath/"src/github.com/max2k1/rps"

    ENV["GOPATH"] = "#{buildpath}/Godeps/_workspace:#{buildpath}"

    Language::Go.stage_deps resources, buildpath/"src"
    system "go", "build", "-o", "rps"

    bin.install "rps"
  end

end
