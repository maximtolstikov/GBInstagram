// Для описания датапровайдера для TagResultDetailPresenter

import SwiftyJSON

class InstagramTagResultDetailDataProvider: TagResultDetailDataProvider {
    
    let apiManager = APIManager()
    
    
    // Возвращает изображение типа Data
    func getImage(urlString: String, completion: @escaping (Data?) -> Void) {
        
        apiManager.downloadImage(urlString: urlString) { (data) in
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            completion(data)
        }
        
    }
}
