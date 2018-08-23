// Для перехода полсле авторизации

import UIKit

class MainViewControllerIphone: UIViewController {    
    
    
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
        let apiManager = APIManager.shared
        let urlForMethod = apiManager.URLFor(apiMethod: methodGetUserData, token: token)
        
        apiManager.load(urlForMethod, { [weak self] (result) in
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
            .instantiateViewController(withIdentifier: "AuthenticationViewController")
        
        present(viewController,
                animated: true,
                completion: nil)
    }
}
