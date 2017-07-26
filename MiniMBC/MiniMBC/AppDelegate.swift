//
//  AppDelegate.swift
//  MiniMBC
//
//  Copyright © 2017 Ghostly. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let next = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    let playpause = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    let previous = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)

    func applicationDidFinishLaunching(_ aNotification: Notification) {

        if let nextButton = next.button {
            nextButton.image = NSImage(named: "next")
            nextButton.action = #selector(self.nextTrack)
        }
        if let playButton = playpause.button {
            playButton.image = NSImage(named: "paused")
            playButton.action = #selector(self.checkAction)
            playButton.sendAction(on: [.leftMouseUp, .rightMouseUp])
        }
        if let previousButton = previous.button {
            previousButton.image = NSImage(named: "previous")
            previousButton.action = #selector(self.previousTrack)
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func checkAction(sender: NSStatusItem) {
        if NSApp.currentEvent!.type == NSEventType.rightMouseUp {
            NSApplication.shared().terminate(self)
        } else {
            playPause()
        }
    }

    func playPause() {
        let PlayPauseScript = "tell application \"Spotify\"\n playpause\n end tell"
        if let scriptObject = NSAppleScript(source: PlayPauseScript) {
            scriptObject.executeAndReturnError(nil)
        }
    }

    func nextTrack() {
        let nextTrackScript = "tell application \"Spotify\"\n next track \n end tell"
        if let scriptObject = NSAppleScript(source: nextTrackScript) {
            scriptObject.executeAndReturnError(nil)
        }
    }

    func previousTrack() {
        let previousTrackScript = "tell application \"Spotify\"\n previous track \n end tell"
        if let scriptObject = NSAppleScript(source: previousTrackScript) {
            scriptObject.executeAndReturnError(nil)
        }
    }
}
