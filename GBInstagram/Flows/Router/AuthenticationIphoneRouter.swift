// Для реализации роутера авторизации

import UIKit

class AuthenticationIphoneRouter: AuthenticationRouter {
    
    weak var viewController: UIViewController?
    
    init(veiwController: UIViewController) {
        
        self.viewController = veiwController
    }
    
    func navigateAuthSuccess() {
        
        //swiftlint:disable force_cast
        let userViewController = UserViewControllerIphoneBilder()
            .viewController() as! UserViewControllerIphone        
        
        viewController?.present(
            userViewController,
            animated: true,
            completion: nil)
    }
}
