// Для конструирования Таб бар контроллера

import UIKit

class TabBarControllerBilder {
    
    func viewController() -> UIViewController {
        
        //swiftlint:disable force_cast
        let tabBarController = UIStoryboard(
            name: "Main",
            bundle: nil)
            .instantiateViewController(
                withIdentifier: "TabBarController") as! TabBarController
        tabBarController.controllers = createControllers()
        
        return tabBarController
    }
    
    
    // Создаем контроллеры для TabBarController
    private func createControllers() -> [UIViewController] {
        
        var controllers = [UIViewController]()
        
        let userViewController = UserViewControllerIphoneBilder()
            .viewController()
        userViewController.tabBarItem = UITabBarItem(
            title: "User",
            image: nil,
            tag: 0)
        controllers.append(userViewController)
        
        let tagSearchController = TagSearchControllerBilder()
            .viewController()
        tagSearchController.tabBarItem = UITabBarItem(
            title: "Find",
            image: nil,
            tag: 1)
        controllers.append(tagSearchController)
        
        return controllers
    }
}
