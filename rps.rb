require "language/go"

class Rps < Formula
  desc "Measure rows-per-second rate by reading access.logs through pipe"
  homepage "https://github.com/max2k1/rps"
  url "https://github.com/max2k1/rps/archive/0.0-3.tar.gz"
  version "0.0-3"
  sha256 "8c5ba8c80401e204f5f53ad713cb5ddcb6d0d3686676af06746647443bf033a1"

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
