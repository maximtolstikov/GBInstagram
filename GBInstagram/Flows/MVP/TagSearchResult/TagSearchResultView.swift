// Для описания интерфейса доступа к TagSearchResultController

import UIKit

protocol TagSearchResultView: AnyObject {
    
    var dataForCell: [TagSearchResultCellModel] { get set }
    
    func moveTo(viewController: UIViewController)
    
}
