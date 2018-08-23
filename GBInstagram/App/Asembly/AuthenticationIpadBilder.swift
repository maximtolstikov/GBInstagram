// Для реалицации строителя контроллера аунтентификации

import UIKit

class AuthenticationIpadBilder: AuthenticationBilder {
    
    func viewController() -> UIViewController {
        
        //swiftlint:disable force_cast
        let authenticationController = UIStoryboard(
            name: "Main",
            bundle: nil)
            .instantiateViewController(
                withIdentifier: "AuthenticationViewController") as! AuthenticationViewController
        let router = AuthenticationIpadRouter(veiwController: authenticationController)
        authenticationController.router = router
        authenticationController.device = DeviceType.iPad
        
        return authenticationController
    }
}
