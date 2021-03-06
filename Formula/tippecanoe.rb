class Tippecanoe < Formula
  desc "Build vector tilesets from collections of GeoJSON features"
  homepage "https://github.com/mapbox/tippecanoe"
  url "https://github.com/mapbox/tippecanoe/archive/1.12.3.tar.gz"
  sha256 "7bf6a1940ba7cd277bffd9c54a15de2159822e008a743a1a1e8e0b6474b446a9"

  bottle do
    cellar :any_skip_relocation
    sha256 "bbf0af5b21c8d6815588bfa094eb30e539d9837c1e24666ee48fd4af02b9acdd" => :el_capitan
    sha256 "96c7f94b77a34660e7a9c0c64cd6f07c2253b6f21f983905ed137b9891d65ffd" => :yosemite
    sha256 "ca1ccc79ceec144094bcfb589942ffeca484049db48de668ccfb81a3cb4680ee" => :mavericks
  end

  def install
    system "make"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    (testpath/"test.json").write <<-EOS.undent
      {"type":"Feature","properties":{},"geometry":{"type":"Point","coordinates":[0,0]}}
    EOS
    safe_system "#{bin}/tippecanoe", "-o", "test.mbtiles", "test.json"
    assert File.exist?("#{testpath}/test.mbtiles"), "tippecanoe generated no output!"
  end
end
