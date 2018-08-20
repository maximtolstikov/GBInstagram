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
        
        let firstViewController: UIViewController
        
        if Credential().isAuthorized {
            
            let mainViewController = UIStoryboard(
                name: "Main",
                bundle: nil)
                .instantiateViewController(withIdentifier: "MainViewController")
            
            firstViewController = mainViewController
            
        } else {
            
            guard let authenticationController = UIStoryboard(
                name: "Main",
                bundle: nil)
                .instantiateViewController(withIdentifier: "AuthViewController") as? AuthViewController else {
                    return false
            }
            
            authenticationController.delegate = self
            firstViewController = authenticationController
        }
        
        self.window?.rootViewController = firstViewController
        self.window?.makeKeyAndVisible()
        return true
    }
}


extension AppDelegate: AuthDelegate {
    func authenticationViewController(
        _ viewController: UIViewController,
        authorizedWith token: String?) {
        
        guard let key = token else { return }
        Credential().saveTokenInKeychain(key)
        
        let mainViewController = UIStoryboard(
            name: "Main",
            bundle: nil)
            .instantiateViewController(withIdentifier: "MainViewController")
        
        viewController.present(mainViewController, animated: true, completion: nil)
    }
}
