#!/usr/bin/env ruby

require "fileutils"
require "erb"
require "rbconfig"

module PhotoStream
  def self.run(args)
    target = args[1] || File.join(ENV["HOME"], "Pictures", "Photo Stream")
    if args[0] == "start"
      start(target)
    elsif args[0] == "stop"
      stop
    elsif args[0] == "sync"
      sync(target)
    else
      puts "Usage: photostream [start|stop] <target directory>"
    end
  end

  BASE_DIRECTORY = File.join(ENV["HOME"], "Library", "Application Support", "iLifeAssetManagement", "assets", "sub")
  PLIST_PATH = File.join(ENV["HOME"], "Library", "LaunchAgents", "com.lazyatom.photostream.plist")
  RUBY_INTERPRETER_PATH = File.join(RbConfig::CONFIG["bindir"],
                                    RbConfig::CONFIG["RUBY_INSTALL_NAME"] +
                                    RbConfig::CONFIG["EXEEXT"])

  PLIST = <<-EOS
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>Label</key>
    <string>com.lazyatom.photostream</string>
    <key>UserName</key>
    <string><%= `whoami`.strip %></string>
    <key>ProgramArguments</key>
    <array>
      <string><%= ruby %></string>
      <string><%= bin %></string>
      <string>sync</string>
      <string><%= target_directory %></string>
    </array>
    <key>KeepAlive</key>
    <false/>
    <key>WatchPaths</key>
    <array>
      <string><%= base_directory %></string>
    </array>
    <key>RunAtLoad</key>
    <true/>
  </dict>
</plist>
EOS

  def self.start(target_directory)
    bin = File.expand_path($0)
    base_directory = BASE_DIRECTORY
    ruby = RUBY_INTERPRETER_PATH
    File.open(PLIST_PATH, "w") do |f|
      f.write ERB.new(PLIST.strip).result(binding)
    end
    `launchctl load #{PLIST_PATH}`
    puts "Started syncing to #{target_directory}"
  end

  def self.stop
    `launchctl unload #{PLIST_PATH}`
    FileUtils.rm(PLIST_PATH) if File.exist?(PLIST_PATH)
    puts "Stopped syncing"
  end

  def self.sync(target_directory)
    puts "Making #{target_directory}"
    FileUtils.mkdir_p(target_directory)
    Dir[File.join(BASE_DIRECTORY, "*", "**")].each do |path|
      FileUtils.ln(path, File.join(target_directory, File.basename(path)), force: true)
    end
    puts "Synced Photo Stream to #{target_directory}"
  end
end
