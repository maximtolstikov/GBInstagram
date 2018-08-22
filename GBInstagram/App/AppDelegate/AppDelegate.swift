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

            firstViewController = authenticationController
        }

        self.window?.rootViewController = firstViewController
        self.window?.makeKeyAndVisible()
        return true
    }
}
