// Для возвращения вьюконтроллера в зависимости от пердоваемого типа
// для устройств Iphone

import UIKit

class FirstViewControllerIphoneFactory: FirstViewControllerFactory {
    
    private func chooseViewController(
        of type: ViewControllerType) -> UIViewController {
        
        switch type {
        case .authVC:
            return AuthenticationIphoneBilder().viewController()
        case .mainVC:
            let mainViewController = UIStoryboard(
                name: "Main",
                bundle: nil)
                .instantiateViewController(withIdentifier: "MainViewControllerIphone")
            return mainViewController
        }
    }
    
    func viewController(isUserAutheticated: Bool) -> UIViewController {
        
        return isUserAutheticated ? chooseViewController(of: .mainVC) : chooseViewController(of: .authVC)
    }
}
