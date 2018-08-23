// Для реализации роутера авторизации для Ipad

import UIKit

class AuthenticationIpadRouter: AuthenticationRouter {
    
    weak var viewController: UIViewController?
    
    init(veiwController: UIViewController) {
        
        self.viewController = veiwController
    }
    
    func navigateAuthSuccess() {
        
        let mainViewController = UIStoryboard(
            name: "Main",
            bundle: nil)
            .instantiateViewController(withIdentifier: "MainViewControllerIpad")
        
        viewController?.present(
            mainViewController,
            animated: true,
            completion: nil)
    }
}
