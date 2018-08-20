// Для перехода полсле авторизации

import UIKit

class MainViewController: UIViewController {
    
    struct API {
        
        static let host = "https://api.instagram.com/v1"
        static let token = "?access_token="
        
        static func URLFor(apiMethod: String, token: String) -> String {
            return self.host + apiMethod + self.token + token
        }
    }
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    var methodGetUserData = "/users/self"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameLabel.text = "loading..."
        getUser()
        
    }
    
    
    // Получение данных пользователя
    func getUser() {
        
        guard let token = Credential().getTokenFromKetchain() else {
            return
        }
        
        APIManager.shared.load(API.URLFor(apiMethod: methodGetUserData, token: token), { [weak self] (result) in
            guard let result = (result as? [String: Any])?["data"] as? [String: Any] else {
                DispatchQueue.main.async {
                    self?.userNameLabel.text = "error"
                }
                return
            }
            let user = User(dictionary: result)
            DispatchQueue.main.async {
                self?.userNameLabel.text = user.userName
            }
        })
    }
    
    @IBAction func logout(_ sender: UIBarButtonItem) {
        
        Credential().deleteTokenFromKeychain()
        
        let viewController = UIStoryboard(
            name: "Main",
            bundle: nil)
            .instantiateViewController(withIdentifier: "AuthViewController")
        
        present(viewController,
                animated: true,
                completion: nil)
    }
}
