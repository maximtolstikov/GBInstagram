// Для описания методов API у контроллера Поиска по тегам

import SwiftyJSON

class InstagramTagSearchDataProvider: TagSearchDataProvider {
    
    let apiManager = APIManager()
    var methodGetUserData = "/tags/search"
    
    
    // Запрашивает и возвращает данные пользователя
    func getTags(with tag: String, completion: @escaping ([Tag]) -> Void) {
        
        guard let savedToken = Credential()
            .getTokenFromKetchain() else { return }
        let urlForMethod = apiManager.urlForTagSearch(
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
            let tags = json["data"].map { Tag(json: $0.1) }

            completion(tags)
            
        })        
    }
}
