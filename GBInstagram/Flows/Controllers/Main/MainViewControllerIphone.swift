// Для перехода полсле авторизации

import UIKit

class MainViewControllerIphone: UIViewController {
    
    @IBOutlet weak var userNameLabel: UILabel!
    lazy var apiManager = APIManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameLabel.text = "loading..."
        getUser()
    }
    
    
    // Отображение данных пользователя
    func getUser() {

        apiManager.getUser { [weak self] (text) in
            DispatchQueue.main.async {
                self?.userNameLabel.text = text
            }
        }
    }
    
    
    @IBAction func logout(_ sender: UIBarButtonItem) {
        
        Credential().deleteTokenFromKeychain()
        
        let viewController = UIStoryboard(
            name: "Main",
            bundle: nil)
            .instantiateViewController(
                withIdentifier: "AuthenticationViewController")
        
        present(viewController,
                animated: true,
                completion: nil)
    }
    
}
