import UIKit

protocol AuthDelegate: class {
    
    func authenticationViewController(
        _ viewController: UIViewController,
        authorizedWith token: String?
    )
}
