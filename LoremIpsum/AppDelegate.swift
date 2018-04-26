//
//  AppDelegate.swift
//  LoremIpsum
//
//  Created by Prachi Gauriar on 4/25/2018.
//  Copyright © 2018 Prachi Gauriar. All rights reserved.
//

import Cocoa


@NSApplicationMain
final class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        NSApplication.shared.servicesProvider = LoremIpsumGenerator()
    }
}
