// Для настройки таббар контроллера

import UIKit

class TabBarController: UITabBarController {
    
    var controllers: [UIViewController]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewControllers = controllers
    }
}
