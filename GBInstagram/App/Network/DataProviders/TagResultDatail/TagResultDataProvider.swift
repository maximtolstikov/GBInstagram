// Для описания интерфейса дата провайдера для TagResultDetail

import UIKit

protocol TagResultDetailDataProvider {
    
    func getImage(urlString: String, completion: @escaping (Data?) -> Void)
    
}
