// Для объединения сетевых запросов в одном месте

import SwiftyJSON
import UIKit

class APIManager {
    
    var imageCache = NSCache<NSString, NSData>()
    
    let host = "https://api.instagram.com/v1"
    let token = "access_token="
    
    
    // Получение стороки запроса
    func urlFor(apiMethod: String, token: String) -> String {
        return self.host + apiMethod + "?" + self.token + token
    }
    
    
    // Получение стороки запроса для поиска по тегу
    func urlForTagSearchResult(tag: String, apiMethod: String, token: String) -> String {
        return self.host + "/tags/" + "\(tag)" + apiMethod + "?" + self.token + token
    }
    
    
    // Получение стороки запроса публикаций по тегу
    func urlForTagSearch(tag: String, apiMethod: String, token: String) -> String {
        return self.host + apiMethod + "?" + "q=\(tag)" + "&" + self.token + token
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
    
    
    // Загрузка изображения по url
    func downloadImage(urlString: String, completion: @escaping (Data?) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        if let cashedImage = imageCache.object(forKey: urlString as NSString) {
            completion(cashedImage as Data)
        } else {
            
            let request = URLRequest(
                url: url,
                cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad,
                timeoutInterval: 0
            )
            URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
                
                guard error == nil,
                    data != nil,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 else {
                        completion(nil)
                        return
                }
                
                //swiftlint:disable force_unwrapping
                self?.imageCache.setObject(data! as NSData, forKey: urlString as NSString)
                completion(data)
                
            }.resume()
        }
    }
}
