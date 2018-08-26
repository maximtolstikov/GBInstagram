// Для объединения сетевых запросов в одном месте

import SwiftyJSON
import UIKit

class APIManager {

    let host = "https://api.instagram.com/v1"
    let token = "?access_token="

    
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
