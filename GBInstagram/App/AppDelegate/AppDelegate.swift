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
        
        self.window = UIWindow()
        let deviceModel = UIDevice.current.model
        var viewController: UIViewController
        var factory: FirstViewControllerFactory
        
        if deviceModel == DeviceType.iPhone.rawValue {
           factory = FirstViewControllerIphoneFactory()
        } else {
            factory = FirstViewControllerIpadFactory()
        }
        
        viewController = factory.viewController(isUserAutheticated: Credential().isAuthorized)

        self.window?.rootViewController = viewController
        self.window?.makeKeyAndVisible()
        
        return true
    }
}
