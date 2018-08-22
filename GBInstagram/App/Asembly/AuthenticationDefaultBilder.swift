// Для реалицации строителя контроллера аунтентификации

import UIKit

class AuthenticationDefaultBilder: AuthenticationBilder {
    
    func viewController() -> UIViewController {
        
        let viewController = AuthViewController()
        let router = AuthenticationDefaultRouter(veiwController: viewController)
        viewController.router = router
        
        return viewController
    }
}
