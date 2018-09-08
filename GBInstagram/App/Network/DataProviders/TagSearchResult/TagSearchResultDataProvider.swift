// Для описания интерфейса дата провайдера для TagSearchResult

import UIKit

protocol TagSearchResultDataProvider {
    
    func getPublics(with tag: String, completion: @escaping ([Public]) -> Void)
    func getImage(urlString: String, completion: @escaping (Data?) -> Void)
    
}
