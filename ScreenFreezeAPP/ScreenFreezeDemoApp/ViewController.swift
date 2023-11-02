//  ViewController.swift
//  ScreenFreezeDemoApp
//
//  Created by Bellubis-WS29 on 17/10/23.
//

import Cocoa
import ApplicationServices
import IOKit
import IOKit.usb
import IOKit.usb.IOUSBLib

class ViewController: NSViewController {
   
    /*var mainWindow: NSWindow {
        //let appDelegate = Appli //UIApplication.shared.delegate as! AppDelegate
        //let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        //let aVariable = appDelegate.mainWindow
        }*/
    
   
   // print(appDelegate.name)
    //let firstName = AppDelegate.givenName
    //let lastName = AppDelegate.familyName
    
    var overlayWindow: NSWindow!
    var overlayPanel: NSPanel!
    var mainWindow: NSWindow!
    var isScreenFrozen = false
    var modalSession: NSApplication.ModalSession?
    var isStayingOnTop = false
    var originalWindowLevel: NSWindow.Level?
    @IBOutlet var freeze: NSButton!
    var deviceList : [String] = []
    
     // Set the app delegate

  
        
    @IBOutlet var unfreeze: NSButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        unfreeze.isHidden = true
        freeze.isHidden = false
        deviceList = getConnectedUSBDevices()
       // for devices in deviceList {
       //     print(devices)
        // }
        //checkToFreeze(deviceList)
        //view.isHidden = true
        //mainWindow = NSApplication.shared.windows.first
       // mainWindow.level = .statusBar
       /* mainWindow = NSApplication.shared.windows.first

               // Set the window style mask to remove the close, minimize, and resizable buttons
               mainWindow.styleMask.remove([.closable, .miniaturizable, .resizable])
               // Set the window to full-screen
               mainWindow.toggleFullScreen(nil)
               mainWindow.styleMask.remove(.resizable)
               mainWindow.standardWindowButton(.zoomButton)?.isHidden = true
               // Hide the title bar
               mainWindow.titlebarAppearsTransparent = true
               mainWindow.titleVisibility = .hidden
               mainWindow.level = .mainMenu + 1
               mainWindow.orderFront(nil) */
          //  mainWindow.makeKeyAndOrderFront(sender
       
        // Do any additional setup after loading the view.
    }
   // override func cancelOperation(_ sender: Any?) {
            // Prevent the default behavior of the Escape key by doing nothing
    //    }
    
    func checkToFreeze(_ devices: [String])
    {
        for device in devices{
            if device.contains("USB")
            {
                freezed()
                break
              
            }
        }
    }
    
    func freezed() {
        guard let appDelegate = NSApplication.shared.delegate as? AppDelegate else {
                   // Access the variable from the app delegate
                  return
                   //print(variableFromAppDelegate) // This will print "Hello from AppDelegate!"
               }
       // var vcMainWindow = appDelegate.mainWindow
        var vcMainWindow = appDelegate.mainWindow
       // enableWindowButtons
        // vcMainWindow = NSApplication.shared.windows.first
        vcMainWindow!.styleMask.remove([.closable, .miniaturizable, .resizable])
        vcMainWindow!.level = .statusBar     //.mainMenu + 1 //.floating
            //mainWindow.collectionBehavior.insert(.canJoinAllSpaces)
        //vcMainWindow!.makeKeyAndOrderFront(sender)
        
       // enableDockAutohide()
        unfreeze.isHidden = false
    }
    
  
    
    override func viewWillAppear(){
        //unfreeze.isHidden = true
       // NSApp.unhide(self)
        //setup()
    }

    /*func applicationDidFinishLaunching(_ aNotification: Notification) {
           // Get a reference to the main window
           if let window = NSApplication.shared.windows.first {
         mainWindow = window
     }

     // Set the collection behavior for the main window to enable full-screen mode
     mainWindow.collectionBehavior = [.fullScreenPrimary]

     // Remove the title bar and window decorations
     mainWindow.styleMask.remove(.titled)
        mainWindow.toolbar = nil

     // Set the presentation options to hide the menu bar
     NSApplication.shared.presentationOptions = [
         .hideMenuBar
     ]
 }*/
    
    func getConnectedUSBDevices() -> [String] {
        var deviceList: io_iterator_t = 0
        let matchingDict = IOServiceMatching(kIOUSBDeviceClassName)
        
        let kernResult = IOServiceGetMatchingServices(kIOMasterPortDefault, matchingDict, &deviceList)
        if kernResult != KERN_SUCCESS {
            return []
        }
        
        var deviceNames: [String] = []
        
        var usbDevice = IOIteratorNext(deviceList)
        while usbDevice != 0 {
            if let name = IORegistryEntryCreateCFProperty(usbDevice, kUSBProductString as CFString, kCFAllocatorDefault, 0)?.takeRetainedValue() as? String {
                deviceNames.append(name)
            }
            
            IOObjectRelease(usbDevice)
            usbDevice = IOIteratorNext(deviceList)
        }
        
        IOObjectRelease(deviceList)
        
        return deviceNames
    }
    
    
    
    @IBAction func Freeze(_ sender: Any) {
        
        guard let appDelegate = NSApplication.shared.delegate as? AppDelegate else {
                   // Access the variable from the app delegate
                  return
                   //print(variableFromAppDelegate) // This will print "Hello from AppDelegate!"
               }
        var vcMainWindow = appDelegate.mainWindow
        
       // enableWindowButtons
        // vcMainWindow = NSApplication.shared.windows.first
        vcMainWindow!.styleMask.remove([.closable, .miniaturizable, .resizable])
        vcMainWindow!.level = .statusBar     //.mainMenu + 1 //.floating
       // vcMainWindow!.toggleFullScreen(nil)
       // vcMainWindow!.collectionBehavior = [.fullScreenPrimary]
            //mainWindow.collectionBehavior.insert(.canJoinAllSpaces)
        vcMainWindow!.makeKeyAndOrderFront(sender)
        
       // enableDockAutohide()
        unfreeze.isHidden = false
    }
    
    @IBAction func Unfreeze(_ sender: Any) {
        
        guard let appDelegate = NSApplication.shared.delegate as? AppDelegate else {
                   // Access the variable from the app delegate
                  return
                   //print(variableFromAppDelegate) // This will print "Hello from AppDelegate!"
               }
        var vcMainWindow = appDelegate.mainWindow

        
        //vcMainWindow = NSApplication.shared.windows.first
        vcMainWindow!.styleMask.insert([.closable, .miniaturizable, .resizable])
        vcMainWindow!.level = .floating
        //vcMainWindow!.toggleFullScreen(nil)
        //vcMainWindow!.miniaturize(sender)
        //vcMainWindow!.makeKeyAndOrderFront(nil)
        NSApp.hide(sender)
      //  NSApp.unhide(sender)
        unfreeze.isHidden = true
           
          //  mainWindow.collectionBehavior.insert(.fullScreenPrimary)
         //mainWindow.orderOut(nil)
        //NSApplication.shared.miniaturizeAll(self)
        //NSApp.mainWindow?.performMiniaturize(nil)
        
    }
    
    
    private func enableDockAutohide() {
            //Enable the Dock autohide if it was previously enabled
            let defaults = UserDefaults.standard
            defaults.set(true, forKey: "autohide")
        }
    
    
    @IBAction func freezeBtnClk(_ sender: Any) {
        
     //   NSApp.terminate(sender)
        
        /*if isScreenFrozen {
                  // Unfreeze the screen or perform other actions as needed
                  isScreenFrozen = false

                  // Re-enable user interaction
                  if let modalSession = self.modalSession {
                      NSApplication.shared.endModalSession(modalSession)
                      self.modalSession = nil
                  }
              } else {
                  // Capture the current screen
                  if let screen = NSScreen.main {
                      if let screenImage = CGWindowListCreateImage(screen.frame, .optionOnScreenBelowWindow, kCGNullWindowID, .nominalResolution) {
                          // You can do something with the captured screenImage here
                          // For example, you can save it to a file or process it in some way.
                          let nsImage = NSImage(cgImage: screenImage, size: NSScreen.main!.frame.size)
                          // Here, we create an NSImage from the CGImage for further processing or display.
                          
                          // Set the flag to indicate that the screen is frozen
                          isScreenFrozen = true

                          // Disable user interaction
                          self.modalSession = NSApplication.shared.beginModalSession(for: self.view.window!)
                      }            }
              }*/
    }
   
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

