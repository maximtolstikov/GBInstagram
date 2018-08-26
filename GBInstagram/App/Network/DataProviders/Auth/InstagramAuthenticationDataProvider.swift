// Для определения методов API у контроллера авторизации

import UIKit

class InstagramAuthenticationDataProvider: AuthenticationDataProvider {
    
    
    // Метод запроса на авторизацию
    func getAuthenticationRequest() -> URLRequest? {
        
        let clientId = "efde2e1af6b24b339b2654cd1660558f"
        let redirectURL = "https://www.instagram.com"
        
        guard let url = URL(
            string: "https://api.instagram.com/oauth/authorize/?client_id=\(clientId)&redirect_uri=\(redirectURL)&response_type=token&scope=public_content"
            ) else { return nil }
        
        let request = URLRequest(
            url: url,
            cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
            timeoutInterval: 10.0
        )
        
        return request
    }
}
