//
//  AppDelegate.swift
//  toufik
//
//  Created by Ratul Sharker on 6/3/21.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        FirebaseApp.configure()
        _ = RemoteCfgMgr.sharedInstance
        
        window = BottomBanneredWindow()
        window?.rootViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateInitialViewController()
        window?.makeKeyAndVisible()
        
        Thread.sleep(forTimeInterval: 2.0)

        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        Banner.sharedInstance.configureBottomBanner()
//        lookupFonts()
    }
    
    // source : https://developer.apple.com/documentation/uikit/text_display_and_fonts/adding_a_custom_font_to_your_app
    func lookupFonts() {
        for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            print("Family: \(family) Font names: \(names)")
        }
    }
}

