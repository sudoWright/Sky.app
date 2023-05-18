//
//  WindowDelegate.swift
//  Sky
//

import Foundation
import AppKit

class WindowDelegate: NSObject, NSWindowDelegate {

    let MIN_DESKTOP_WIDTH = 1230.0
    var lastDesktopMode: Bool? = nil

    func windowWillResize(_ sender: NSWindow, to frameSize: NSSize) -> NSSize {
        updateWindowDesktopMode(frameSize.width)
        return frameSize
    }

    func updateWindowDesktopMode(_ frameWidth: CGFloat) {
        let desktopMode = frameWidth >= MIN_DESKTOP_WIDTH
        if lastDesktopMode != desktopMode {
            lastDesktopMode = desktopMode

            updateViewNavigation(desktopMode)
        }
    }

    func updateViewNavigation(_ desktopMode: Bool) {
        let mainMenu = NSApplication.shared.mainMenu!
        let viewMenu = mainMenu.item(withTitle: "View")?.submenu

        let moderationMenuItem = viewMenu?.item(withTitle: "Moderation")
        let profileMenuItem = viewMenu?.item(withTitle: "Profile")
        let settingsMenuItem = viewMenu?.item(withTitle: "Settings")

        if desktopMode {
            // show moderation, profile, settings
            showMenuItem(moderationMenuItem!, commandNumber: 4)
            showMenuItem(profileMenuItem!, commandNumber: 5)
            showMenuItem(settingsMenuItem!, commandNumber: 6)
        } else {
            // hide moderation, settings, profile
            hideMenuItem(moderationMenuItem!)
            hideMenuItem(settingsMenuItem!)
            hideMenuItem(profileMenuItem!)
            // show settings
            showMenuItem(profileMenuItem!, commandNumber: 4)
        }
    }

    func showMenuItem(_ menuItem: NSMenuItem, commandNumber: Int) {
        menuItem.isHidden = false
        menuItem.keyEquivalent = "\(commandNumber)"
        menuItem.keyEquivalentModifierMask = .command
    }

    func hideMenuItem(_ menuItem: NSMenuItem) {
        menuItem.isHidden = true
        menuItem.keyEquivalent = ""
        menuItem.keyEquivalentModifierMask = NSEvent.ModifierFlags()
    }

}