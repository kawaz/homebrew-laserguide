# frozen_string_literal: true

cask "laserguide" do
  version "0.8.0"
  sha256 "05bb4ed0e5d7cac23f597a06c1494de8259682db75d3d72b738b0ebfa99206ed"

  url "https://github.com/kawaz/LaserGuide/releases/download/v#{version}/LaserGuide-#{version}.zip"
  name "LaserGuide"
  desc "Display laser lines from screen corners to your mouse cursor"
  homepage "https://github.com/kawaz/LaserGuide"

  depends_on macos: ">= :sequoia"

  # アップグレード時にも既存プロセスを終了（エラーは無視）
  preflight do
    system_command "/usr/bin/pkill",
                   args:         ["-f", "LaserGuide"],
                   sudo:         false,
                   print_stderr: false
  rescue StandardError
    # プロセスが見つからない場合はエラーを無視
    nil
  end

  app "LaserGuide.app"

  uninstall quit: "jp.kawaz.LaserGuide"

  zap trash: [
    "~/Library/Preferences/jp.kawaz.LaserGuide.plist",
    "~/Library/Saved Application State/jp.kawaz.LaserGuide.savedState",
  ]
end
