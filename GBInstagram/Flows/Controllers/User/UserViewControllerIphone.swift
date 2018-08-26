// Для перехода полсле авторизации

import UIKit

class UserViewControllerIphone: UIViewController {
    
    @IBOutlet weak var userNameLabel: UILabel!
    var dataProvider: UserDataProvider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameLabel.text = "loading..."
        getUser()
    }
    
    
    // Отображение данных пользователя
    func getUser() {

        dataProvider.getUserData { [weak self] (text) in
            DispatchQueue.main.async {
                self?.userNameLabel.text = text
            }
        }
    }
    
    
    @IBAction func logout(_ sender: UIBarButtonItem) {
        
        Credential().deleteTokenFromKeychain()
        
        let viewController = AuthenticationIphoneBilder().viewController()
        
        present(viewController,
                animated: true,
                completion: nil)
    }
    
}
