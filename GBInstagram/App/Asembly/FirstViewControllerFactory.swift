// Для определения интерфейса фабрики по созданию FirstViewController

import UIKit

protocol FirstViewControllerFactory {
    
    func viewController(isUserAutheticated: Bool) -> UIViewController
}
