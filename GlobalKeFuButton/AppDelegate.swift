//
//  AppDelegate.swift
//  GlobalKeFuButton
//
//  Created by 范庆宇 on 2021/6/16.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        let vc = ViewController()
        let nav = UINavigationController.init(rootViewController: vc)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        return true
    }

    
}

