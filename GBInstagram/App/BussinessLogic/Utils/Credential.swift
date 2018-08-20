// Для удобного хранения/извлечения токена
// Используем библиотеку Locksmith

import Locksmith

class Credential {
    
    let myAccount = "MyAccount"
    
    private var token: String? {
        
        get {
            guard let dictionary = Locksmith
                .loadDataForUserAccount(userAccount: myAccount) else {
                    return nil
            }
            return dictionary["token"] as? String
        }
        set {
            try? Locksmith.saveData(
                data: ["token": newValue as Any],
                forUserAccount: myAccount
            )
        }
    }
    
    var isAuthorized: Bool {
        if token != nil {
            return true
        }
        return false
    }
    
    
    // Записываем значение в Keychain
    func saveTokenInKeychain(_ token: String) {
        
        self.token = token
    }
    
    
    // Получаем токен
    func getTokenFromKetchain() -> String? {
        
        return token
    }
    
    
    // Удаляем токен пользователя
    func deleteTokenFromKeychain() {
        
        try? Locksmith.deleteDataForUserAccount(userAccount: myAccount)
    }
}
