// Для объединения сетевых запросов в одном месте

import UIKit

class APIManager {
    
    static let shared = APIManager()
    
    private init() {}
    
    let host = "https://api.instagram.com/v1"
    let token = "?access_token="
    
    
    
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
    func URLFor(apiMethod: String, token: String) -> String {
        return self.host + apiMethod + self.token + token
    }
    
    
    // Загрузка данных с сервера зависит от метода
    func load(_ urlString: String, _ completion: @escaping (Any?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        let session = URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            completion(try? JSONSerialization.jsonObject(
                with: data,
                options: .mutableContainers))
            
        }
        session.resume()
    }
}
