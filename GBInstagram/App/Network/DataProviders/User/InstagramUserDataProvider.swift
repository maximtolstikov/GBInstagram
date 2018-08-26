// Для определения методов API у контроллера пользователя

import SwiftyJSON

class InsragramUserDataProvider: UserDataProvider {


    let apiManager = APIManager()
    var methodGetUserData = "/users/self"

        
        // Запрашивает и возвращает данные пользователя
        func getUserData(completion: @escaping (String) -> Void) {
            
            guard let savedToken = Credential()
                .getTokenFromKetchain() else { return }
            let urlForMethod = apiManager.urlFor(
                apiMethod: methodGetUserData,
                token: savedToken
            )
            apiManager.load(urlForMethod, {(data) in
                
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

}
