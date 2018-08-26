// Для создания и конфигурации UserViewController

import UIKit

class UserViewControllerBilder {
    
    
    //swiftlint:disable force_cast
    func viewController() -> UIViewController {
        
        let userController = UIStoryboard(
            name: "Main",
            bundle: nil)
            .instantiateViewController(
                withIdentifier: "UserViewControllerIphone") as! UserViewControllerIphone
        
        userController.dataProvider = APIManager()
        
        return userController
    }
}
