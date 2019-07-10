//
//  AppDelegate.swift
//  UIML
//
//  Created by Кольцов Павел on 04.07.2019.
//  Copyright © 2019 Skyeng. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        
        window?.rootViewController = UINavigationController(rootViewController: ViewController())
        let navBar = UINavigationBar.appearance()
        navBar.isTranslucent = false
        
        window?.makeKeyAndVisible()
        return true
    }
}

