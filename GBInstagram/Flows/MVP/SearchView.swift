// Интерфейс для доступа Презентера к Вью

import UIKit

protocol SearchView: AnyObject {
    
    var query: String? { get set }
    var searchResult: [SearchResultCellModel]? { get set }
    
    func moveTo(viewController: UIViewController)
    
}
