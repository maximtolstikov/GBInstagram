// Интерфейс для доступа Презентера к Вью

import UIKit

protocol TagSearchView: AnyObject {
    
    var query: String? { get set }
    var searchResult: [TagSearchCellModel]? { get set }
    
    func moveTo(viewController: UIViewController)
    
}
