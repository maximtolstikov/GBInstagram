// Для определения методов API у контроллера пользователя

import SwiftyJSON

class InsragramUserDataProvider: UserDataProvider {
    
    let apiManager = APIManager()
    var methodGetUserData = "/users/self"
    
    
    // TODO: - требуется изменить логику передачи userID
    // Запрашивает и возвращает данные пользователя (попутно записывает userId)
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
            
            self.saveUserId(with: users[1].identifier)
            
            completion(users[1].fullName)
            
        })
    }
    
    
    // Сохраняет идентификатор пользователя в UserDefaults
    private func saveUserId(with identifire: Int) {
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(identifire, forKey: "instagramUserId")
    }
    
}
