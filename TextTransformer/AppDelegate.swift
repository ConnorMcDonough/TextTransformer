//
//  AppDelegate.swift
//  TextTransformer
//
//  Created by Connor McDonough on 5/25/21.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    let font = NSFont.monospacedDigitSystemFont(ofSize: 24.0, weight: NSFont.Weight.bold)
    //NSFont *font = [NSFont fontWithName:@"LucidaGrande" size:22.0];


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        statusItem.button?.title = "𝑎"
        statusItem.button?.font = font
        statusItem.button?.target = self
        statusItem.button?.action = #selector(showSettings)
        
        if let button = statusItem.button {
            button.performClick(nil)
        }
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    @objc func showSettings() {
        let storyboard = NSStoryboard(name: "Main", bundle: nil /*main would work too*/)
        guard let vc = storyboard.instantiateController(withIdentifier: "ViewController") as? ViewController else {
            fatalError("Unable to find ViewController in storybaord")
        }
        
        guard let button = statusItem.button else {
            fatalError("Couldn't find status item button.")
        }
        
        let popoverView = NSPopover()
        popoverView.contentViewController = vc
        popoverView.behavior = .transient
        popoverView.show(relativeTo: statusItem.button!.bounds, of: button, preferredEdge: .maxY)
    }
}

