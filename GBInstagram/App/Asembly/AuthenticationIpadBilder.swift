// Для реалицации строителя контроллера аунтентификации

import UIKit

class AuthenticationIpadBilder: AuthenticationBilder {
    
    func viewController() -> UIViewController {
        
        let viewController = AuthenticationViewController()
        let router = AuthenticationIpadRouter(veiwController: viewController)
        viewController.router = router
        
        return viewController
    }
}
