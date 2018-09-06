// Для реализации роутера авторизации

import UIKit

class AuthenticationIphoneRouter: AuthenticationRouter {
    
    weak var viewController: UIViewController?
    
    init(veiwController: UIViewController) {
        
        self.viewController = veiwController
    }
    
    func navigateAuthSuccess() {
        
        let tabBarController = TabBarControllerBilder()
            .viewController()
        
        viewController?.present(
            tabBarController,
            animated: true,
            completion: nil)
    }
}
