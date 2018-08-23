//
//  AppDelegate.swift
//  GBInstagram
//
//  Created by Maxim Tolstikov on 18/08/2018.
//  Copyright © 2018 Maxim Tolstikov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {        
        
        let vc = AuthenticationViewController()
        print("vc: \(vc.wkWebView)")
        
        self.window = UIWindow()

        let firstViewController: UIViewController
        let factory = FirstViewControllerIphoneFactory()
        let viewController = factory.viewController(
            isUserAutheticated: Credential().isAuthorized)
        firstViewController = viewController
        self.window?.rootViewController = firstViewController
        self.window?.makeKeyAndVisible()
        
        return true
    }
}
