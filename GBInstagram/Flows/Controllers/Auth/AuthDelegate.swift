import UIKit

protocol AuthDelegate: AnyObject {
    
    func authenticationViewController(
        _ viewController: UIViewController,
        authorizedWith token: String?
    )
}
