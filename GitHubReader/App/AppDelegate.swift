//
//  AppDelegate.swift
//  GitHubReader
//
//  Created by Kaique Monteiro on 30/08/21.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = ViewController()
        self.window = window
        window.makeKeyAndVisible()
        return true
    }

}
