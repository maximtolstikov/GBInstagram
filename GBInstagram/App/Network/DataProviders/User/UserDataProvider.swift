// Для определения интерфейса контроллера пользователя
// к ApiManager

protocol UserDataProvider {
    
    func getUserData(completion: @escaping (String) -> Void)}
