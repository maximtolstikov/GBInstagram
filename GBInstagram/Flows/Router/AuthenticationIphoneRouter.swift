// Для реализации роутера авторизации

import UIKit

class AuthenticationIphoneRouter: AuthenticationRouter {
    
    weak var viewController: UIViewController?
    
    init(veiwController: UIViewController) {
        
        self.viewController = veiwController
    }
    
    func navigateAuthSuccess() {
        
        let tabBarController = UIStoryboard(
            name: "Main",
            bundle: nil)
            .instantiateViewController(
                withIdentifier: "TabBarController")
        
        viewController?.present(
            tabBarController,
            animated: true,
            completion: nil)
    }
}
