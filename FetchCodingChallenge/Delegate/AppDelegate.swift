//
//  AppDelegate.swift
//  FetchCodingChallenge
//
//  Created by Jacob Gleason on 10/12/23.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    lazy var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Initialize the root view
        window?.rootViewController = UINavigationController(rootViewController: MealsViewController(category: "Dessert"))
        window?.makeKeyAndVisible()
        return true
    }
}
