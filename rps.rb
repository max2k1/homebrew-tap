require "language/go"

class Rps < Formula
  desc "Measure rows-per-second rate by reading access.logs through pipe"
  homepage "https://github.com/max2k1/rps"
  url "https://github.com/max2k1/rps/archive/0.0-7.tar.gz"
  version "0.0-7"
  sha256 "a538f0a7d20e8f0630eb6b1171cdd5427fb3d22a68f67d9dbdd093cac45b54e7"

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
