// Для реализации роутера авторизации

import UIKit

class AuthenticationDefaultRouter: AuthenticationRouter {
    
    weak var viewController: UIViewController?
    
    init(veiwController: UIViewController) {
        
        self.viewController = veiwController
    }
    
    func navigateAuthSuccess() {
        
        let mainViewController = UIStoryboard(
            name: "Main",
            bundle: nil)
            .instantiateViewController(withIdentifier: "MainViewController")
        
        viewController?.present(
            mainViewController,
            animated: true,
            completion: nil)
    }
}
