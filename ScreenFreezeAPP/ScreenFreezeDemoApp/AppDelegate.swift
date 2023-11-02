//
//  AppDelegate.swift
//  ScreenFreezeDemoApp
//
//  Created by Bellubis-WS29 on 17/10/23.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate,NSWindowDelegate {
    var overlayWindow: NSWindow!
    var mainWindow: NSWindow!
    // Create a window controller and its associated view controller
    let viewController = ViewController()
    let newwindowController = NSWindowController(window: nil)
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
           // Allow the app to remain open after closing all windows.
           return false
       }
 
   
     /*  func applicationWillFinishLaunching(_ notification: Notification) {
           NSApp.disableRelaunchOnLogin()
           // Implement any state restoration code here.
       } */
    
   
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        mainWindow = NSApplication.shared.windows.first
        //Set the window to full-screen
        mainWindow.toggleFullScreen(nil)
        mainWindow.styleMask.remove(.resizable)
        mainWindow.standardWindowButton(.zoomButton)?.isHidden = true
       // mainWindow.collectionBehavior = [.fullScreenPrimary]
        mainWindow.level = .floating
        mainWindow.makeKeyAndOrderFront(nil)
        
        //mainWindow.collectionBehavior = [.canJoinAllSpaces, .fullScreenPrimary]
       // newwindowController.contentViewController = viewController
        
      /*  if let screen = NSScreen.main {
                // Create a window with a frame that matches the screen
              /*  let window = NSWindow(contentRect: screen.frame,
                                      styleMask: [.borderless],
                                      backing: .buffered,
                                      defer: false)
                window.isReleasedWhenClosed = false

                // Set the window level to floating if needed
            window.level = .statusBar
            
            window.standardWindowButton(.zoomButton)?.isHidden = true
            window.styleMask.insert([.closable, .miniaturizable, .resizable])

                // Set other window properties as desired
                window.contentViewController = newwindowController.contentViewController
                window.collectionBehavior = [.canJoinAllSpaces, .fullScreenPrimary]

                // Make the window key and order it to the front
                window.makeKeyAndOrderFront(nil)

                // Set your app's window as the main window
                mainWindow = window
            }*/
      
        /*if let screen = NSScreen.main {
                  let window = NSWindow(contentRect: screen.frame, styleMask: [.borderless], backing: .buffered, defer: false)
                  window.isReleasedWhenClosed = false
                  window.level = .floating  // Set the window level to floating
                  window.collectionBehavior = [.canJoinAllSpaces, .fullScreenPrimary]
                  window.makeKeyAndOrderFront(nil)
              }*/
        
       /* mainWindow = NSApplication.shared.windows.first
        //Set the window to full-screen
        mainWindow.toggleFullScreen(nil)
        mainWindow.styleMask.remove(.resizable)
        mainWindow.standardWindowButton(.zoomButton)?.isHidden = true*/
        //mainWindow.collectionBehavior = [.fullScreenPrimary]
        overlayWindow = NSWindow(
                   contentRect: NSScreen.main!.frame,
                   styleMask: [.borderless, .nonactivatingPanel],
                   backing: .buffered,
                   defer: false
               )
               
               // Set the window level to stay on top of other windows
             overlayWindow.level = .statusBar
             //overlayWindow.toggleFullScreen(nil)
               // Make the window transparent
             overlayWindow.isOpaque = false
             overlayWindow.backgroundColor = NSColor.clear
               
               // Create a custom view to hold your content
             /*  let customView = NSView(frame: overlayWindow.contentView!.frame)
               
               // Customize your overlay content
               let label = NSTextField(labelWithString: "Custom Overlay Content")
               label.alignment = .center
               label.frame = NSRect(x: 0, y: 0, width: customView.frame.size.width, height: customView.frame.size.height)
               label.textColor = NSColor.white
               label.font = NSFont.systemFont(ofSize: 24)
               customView.addSubview(label)
               
               overlayWindow.contentView?.addSubview(customView)
        mainWindow = NSApplication.shared.windows.first
              
              // Set the window's level to stay on top
              mainWindow.level = .floating */*/
        
    }
  func applicationWillBecomeActive(_ notification: Notification) {
        mainWindow = NSApplication.shared.windows.first
        mainWindow.makeKeyAndOrderFront(nil)
        mainWindow.toggleFullScreen(nil)
       mainWindow.styleMask.remove(.resizable)
       mainWindow.standardWindowButton(.zoomButton)?.isHidden = true
      // mainWindow.collectionBehavior = [.fullScreenPrimary]
    mainWindow.level = .floating
    mainWindow.makeKeyAndOrderFront(nil)
    //mainWindow.toggleFullScreen(nil)
   // mainWindow.collectionBehavior = [.canJoinAllSpaces, .fullScreenPrimary]
       //mainWindow.makeKeyAndOrderFront(nil)
      
    }
    
   /* @IBAction func showOverlay(_ sender: NSButton) {
            // Show the overlay when the button is pressed
            overlayWindow.makeKeyAndOrderFront(nil)
        }*/
    
    func windowWillMiniaturize(_ notification: Notification) {
            // Cancel the minimization
            if let window = notification.object as? NSWindow {
                window.miniaturize(nil)
            }
        }
   /* @IBAction func bringToFrontAndStayOnTop(_ sender: NSButton) {
           if let mainWindow = NSApplication.shared.windows.first {
               mainWindow.level = .floating
               mainWindow.collectionBehavior.insert(.canJoinAllSpaces)
               mainWindow.makeKeyAndOrderFront(sender)
           }
       }*/
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "ScreenFreezeDemoApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving and Undo support

    @IBAction func saveAction(_ sender: AnyObject?) {
        // Performs the save action for the application, which is to send the save: message to the application's managed object context. Any encountered errors are presented to the user.
        let context = persistentContainer.viewContext

        if !context.commitEditing() {
            NSLog("\(NSStringFromClass(type(of: self))) unable to commit editing before saving")
        }
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Customize this code block to include application-specific recovery steps.
                let nserror = error as NSError
                NSApplication.shared.presentError(nserror)
            }
        }
    }

    func windowWillReturnUndoManager(window: NSWindow) -> UndoManager? {
        // Returns the NSUndoManager for the application. In this case, the manager returned is that of the managed object context for the application.
        return persistentContainer.viewContext.undoManager
    }

    func applicationShouldTerminate(_ sender: NSApplication) -> NSApplication.TerminateReply {
        // Save changes in the application's managed object context before the application terminates.
        let context = persistentContainer.viewContext
        if !context.commitEditing() {
            NSLog("\(NSStringFromClass(type(of: self))) unable to commit editing to terminate")
            return .terminateCancel
        }
        if !context.hasChanges {
            return .terminateNow
        }
        
        do {
            try context.save()
        } catch {
            let nserror = error as NSError

            // Customize this code block to include application-specific recovery steps.
            let result = sender.presentError(nserror)
            if (result) {
                return .terminateCancel
            }
            
            let question = NSLocalizedString("Could not save changes while quitting. Quit anyway?", comment: "Quit without saves error question message")
            let info = NSLocalizedString("Quitting now will lose any changes you have made since the last successful save", comment: "Quit without saves error question info");
            let quitButton = NSLocalizedString("Quit anyway", comment: "Quit anyway button title")
            let cancelButton = NSLocalizedString("Cancel", comment: "Cancel button title")
            let alert = NSAlert()
            alert.messageText = question
            alert.informativeText = info
            alert.addButton(withTitle: quitButton)
            alert.addButton(withTitle: cancelButton)
            
            let answer = alert.runModal()
            if answer == .alertSecondButtonReturn {
                return .terminateCancel
            }
        }
        // If we got here, it is time to quit.
      //  return .terminateNow
        
        let alert = NSAlert()
        alert.messageText = "You cant quit until you remove the usb?"
        alert.informativeText = "Any unsaved changes will be lost."
        alert.addButton(withTitle: "Okay")
       // alert.addButton(withTitle: "Cancel")

        let response = alert.runModal()

        if response == .alertFirstButtonReturn {
            return .terminateLater
        } else {
            return .terminateCancel
        }
    }

}

