// Для объединения сетевых запросов в одном месте

import SwiftyJSON
import UIKit

class APIManager {

    let textError = "error"
    let host = "https://api.instagram.com/v1"
    let token = "?access_token="
    var methodGetUserData = "/users/self"
    var methodGetMediaOfUser = "/users/self/media/recent"
    var methodSearchTag = "/tags/search"
    
    
    //Получение фото по тегу
    func getPhotoForTag(_ tag: Tag, _ completion: @escaping (String) -> Void) {
        
        guard let savedToken = Credential()
            .getTokenFromKetchain() else { return }
        let urlForMethod = host + "/tags/" + tag.name + "/media/recent" + token + savedToken
        
        load(urlForMethod, { (data) in
            
            guard let data = data else {
                completion("")
                return
            }
            
            let json = JSON(data)
            let tags = json[0].map { Tag(json: $0.1) }
            
            completion("")
        })
    }
    
    
    //Поиск по тегу
    func searchTag(completion: @escaping (String) -> Void) {
        
        guard let savedToken = Credential()
            .getTokenFromKetchain() else { return }
        let urlForMethod = urlFor(
            apiMethod: methodSearchTag,
            token: savedToken
        )
        
        load(urlForMethod, { (data) in
            
            guard let data = data else {
                completion("")
                return
            }
            
            let json = JSON(data)
            let tags = json[0].map { Tag(json: $0.1) }
            
            completion("")
        })
    }
    
    
    // Получение публикаций пользователя
    func getMediaOfUser(completion: @escaping (String) -> Void) {

        guard let savedToken = Credential()
            .getTokenFromKetchain() else { return }
        let urlForMethod = urlFor(
            apiMethod: methodGetMediaOfUser,
            token: savedToken
        )
        
        load(urlForMethod, { (data) in

            guard let data = data else {
                completion("")
                return
            }
            
            let json = JSON(data)
            let publication = json[0].map { Public(json: $0.1) }
            
            completion("")
        })
    }
    
    
    // Запрашивает и возвращает данные пользователя
    func getUserData(completion: @escaping (String) -> Void) {
        
        guard let savedToken = Credential()
            .getTokenFromKetchain() else { return }
        let urlForMethod = urlFor(
            apiMethod: methodGetUserData,
            token: savedToken
            )
        load(urlForMethod, {(data) in
            
            guard let data = data else {
                completion("")
                return
            }
            let json = JSON(data)
            let users = json.map { User(json: $0.1) }
            
            print("urlFromGetUser: \(urlForMethod)")

            completion(users[1].fullName)
            
        })

    }
    
    
    // Метод запроса на авторизацию
    static func getAuthenticationRequest() -> URLRequest? {
        
        let clientId = "efde2e1af6b24b339b2654cd1660558f"
        let redirectURL = "https://www.instagram.com"
        
        guard let url = URL(
            string: "https://api.instagram.com/oauth/authorize/?client_id=\(clientId)&redirect_uri=\(redirectURL)&response_type=token"
            ) else { return nil }
        
        let request = URLRequest(
            url: url,
            cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
            timeoutInterval: 10.0
        )
        
        return request
    }
    
    
    // Получение стороки запроса
    func urlFor(apiMethod: String, token: String) -> String {
        return self.host + apiMethod + self.token + token
    }
    
    
    // Загрузка данных с сервера зависит от метода
    func load(_ urlString: String, _ completion: @escaping (Any?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        let session = URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard error == nil else {
                completion(nil)
                return
            }
            completion(data)

        }
        session.resume()
    }

}
