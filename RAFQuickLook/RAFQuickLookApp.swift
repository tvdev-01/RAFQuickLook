//
//  RAFQuickLookApp.swift
//  RAFQuickLook
//
//  Created by Michael Costello on 25/11/2025.
//

import SwiftUI

@main
struct RAFQuickLookApp: App {

    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        true
    }
}
