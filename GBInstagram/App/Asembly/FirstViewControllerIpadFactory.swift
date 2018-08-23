// Для возвращения вьюконтроллера в зависимости от пердоваемого типа

import UIKit

private enum ViewControllerType {
    case mainVC
    case authVC
}


class FirstViewControllerIpadFactory {
    
    private func chooseViewController(
        of type: ViewControllerType) -> UIViewController {
        
        switch type {
        case .authVC:
            return AuthenticationIpadBilder().viewController()
        case .mainVC:
            let mainViewController = UIStoryboard(
                name: "Main",
                bundle: nil)
                .instantiateViewController(withIdentifier: "MainViewControllerIpad")
            return mainViewController
        }
    }
    
    func viewController(isUserAutheticated: Bool) -> UIViewController {
        
        return isUserAutheticated ? chooseViewController(of: .mainVC) : chooseViewController(of: .authVC)
    }
}
