//Для организации переходов в одном месте

import UIKit

class Router: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewController = UIStoryboard(
            name: "Main",
            bundle: nil)
            .instantiateViewController(withIdentifier: "AuthViewController")

        setRootVC(viewController: viewController)
    }
    
    
    func checkAuthentification() {
        
        let credential = Credential()
        
        if credential.isAuthorized {
            
            let viewController = UIStoryboard(
                name: "Main",
                bundle: nil)
                .instantiateViewController(withIdentifier: "MainViewController")

            setRootVC(viewController: viewController)
            
            present(viewController, animated: true, completion: nil)
            
        } else {
            
            guard let authenticationController = UIStoryboard(
                name: "Main",
                bundle: nil)
                .instantiateViewController(
                    withIdentifier: "AuthViewController") as? AuthViewController else { return }
            
            authenticationController.delegate = self
            setRootVC(viewController: authenticationController)
            
            present(
                authenticationController,
                animated: true,
                completion: nil )
        }
    }
    
    
    //Устанавливает корневой вьюконтроллер
    private func setRootVC(viewController: UIViewController) {
        
        let window = UIApplication.shared.windows.first
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
    
}


extension Router: AuthDelegate {
    
    // Выполняем перход после успешной регистрации сохраняя токен
    func authenticationViewController(
        _ viewController: UIViewController,
        authorizedWith token: String?) {
        
        guard let key = token else { return }
        Credential().saveTokenInKeychain(key)
        
        print("This")
        
        let viewController = UIStoryboard(
            name: "Main",
            bundle: nil)
            .instantiateViewController(withIdentifier: "MainViewController")
        
        present(
            viewController,
            animated: true,
            completion: nil)
    }
}
