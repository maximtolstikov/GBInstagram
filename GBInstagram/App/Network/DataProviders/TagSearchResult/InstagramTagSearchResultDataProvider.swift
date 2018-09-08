// Для описания датапровайдера для TagSearchResultPresenter

import SwiftyJSON

class InstagramTagSearchResultDataProvider: TagSearchResultDataProvider {
    
    let apiManager = APIManager()
    var methodGetUserData = "/media/recent"
    
    
    // Запрашивает и возвращает данные пользователя
    func getPublics(with tag: String, completion: @escaping ([Public]) -> Void) {
        
        guard let savedToken = Credential()
            .getTokenFromKetchain() else { return }
        let urlForMethod = apiManager.urlForTagSearchResult(
            tag: tag,
            apiMethod: methodGetUserData,
            token: savedToken
        )
        
        apiManager.load(urlForMethod, {(data) in
            
            guard let data = data else {
                completion([])
                return
            }
            let json = JSON(data)
            let publications = json["data"].map { Public(json: $0.1) }
            
            completion(publications)
            
        })
    }
    
    
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
