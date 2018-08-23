// Для реалицации строителя контроллера аунтентификации

import UIKit

class AuthenticationIphoneBilder: AuthenticationBilder {
    
    func viewController() -> UIViewController {
        
        let viewController = AuthenticationViewController()
        let router = AuthenticationIphoneRouter(veiwController: viewController)
        viewController.router = router
        
        print(viewController.wkWebView)
        
        return viewController
    }
}
