cask "eclipse-ide" do
  arch arm: "aarch64", intel: "x86_64"

  version "4.33.0,2024-09"
  sha256 arm:   "209c4673298c5ede9c6f08295ce5d7db14dcbaee64e9781e1c95c295e5c21ae5",
         intel: "0abbd3d1eb4919fad418049673ab20abe3477ccbf6203e4805b24a779b8c5e23"

  url "https://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/#{version.csv.second}/R/eclipse-committers-#{version.csv.second}-R-macosx-cocoa-#{arch}.dmg&r=1"
  name "Eclipse IDE for Eclipse Committers"
  desc "Eclipse integrated development environment"
  homepage "https://eclipse.org/"

  livecheck do
    url "https://www.eclipse.org/downloads/packages/"
    regex(/href=.*?eclipse-committers-(\d+-\d+)-R-mac/i)
    strategy :page_match do |page, regex|
      date = page[regex, 1]
      next if date.blank?

      version_page = Homebrew::Livecheck::Strategy.page_content("https://projects.eclipse.org/releases/#{date}")[:content]
      next if version_page.blank?

      version = version_page[%r{href=["']?/projects/technology\.packaging/releases/v?(\d+(?:\.\d+)+)/?["']?}i, 1]
      next if version.blank?

      "#{version},#{date}"
    end
  end

  app "Eclipse.app"

  zap trash: "~/Library/Preferences/epp.package.committers.plist"
end
