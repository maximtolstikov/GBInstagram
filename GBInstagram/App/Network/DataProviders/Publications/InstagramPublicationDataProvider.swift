// Для описания методов API у конроллера Публикаций

import SwiftyJSON
import UIKit

class InstagramPublicationDataProvider: PublicationDataProvider {
    
    
    var apiManager = APIManager()
    var methodGetMediaOfUser = "/users/self/media/recent"
    var methodSearchTag = "/tags/search"
    let textError = "error"
    let host = "https://api.instagram.com/v1"
    let token = "?access_token="
    
    
    //Получение фото по тегу
    func getPhotoForTag(_ tag: Tag, _ completion: @escaping (String) -> Void) {
        
        guard let savedToken = Credential()
            .getTokenFromKetchain() else { return }
        let urlForMethod = host + "/tags/" + tag.name + "/media/recent" + token + savedToken
        
        apiManager.load(urlForMethod, { (data) in
            
            guard let data = data else {
                completion("")
                return
            }
            
            //let json = JSON(data)
            //let tags = json[0].map { Tag(json: $0.1) }
            
            completion("")
        })
    }
    
    
    //Поиск по тегу
    func searchTag(completion: @escaping (String) -> Void) {
        
        guard let savedToken = Credential()
            .getTokenFromKetchain() else { return }
        let urlForMethod = apiManager.urlFor(
            apiMethod: methodSearchTag,
            token: savedToken
        )
        
        apiManager.load(urlForMethod, { (data) in
            
            guard let data = data else {
                completion("")
                return
            }
            
            //let json = JSON(data)
            //let tags = json[0].map { Tag(json: $0.1) }
            
            completion("")
        })
    }
    
    
    // Получение публикаций пользователя
    func getMediaOfUser(completion: @escaping (String) -> Void) {
        
        guard let savedToken = Credential()
            .getTokenFromKetchain() else { return }
        let urlForMethod = apiManager.urlFor(
            apiMethod: methodGetMediaOfUser,
            token: savedToken
        )
        
        apiManager.load(urlForMethod, { (data) in
            
            guard let data = data else {
                completion("")
                return
            }
            
            //let json = JSON(data)
            //let publication = json[0].map { Public(json: $0.1) }
            
            completion("")
        })
    }
}
