////Для организации переходов в одном месте
//
//import UIKit
//
//class Router: UIViewController {
//    
//    func checkAuthentification() {
//        
//        let credential = Credential()
//        
//        if credential.isAuthorized {
//            
//            let viewController = UIStoryboard(
//                name: "Main",
//                bundle: nil)
//                .instantiateViewController(withIdentifier: "MainViewController")
//            
//            // TODO: сделать презент на главный vc
//            
//        } else {
//            
//            guard let authenticationController = UIStoryboard(
//                name: "Main",
//                bundle: nil)
//                .instantiateViewController(
//                    withIdentifier: "AuthViewController") as? AuthViewController else { return }
//            
//            authenticationController.delegate = self
//            
//            present(
//                authenticationController,
//                animated: true,
//                completion: nil )
//        }
//    }
//    
//}
//
//
//extension Router: AuthDelegate {
//    
//    // Выполняем перход после успешной регистрации сохраняя токен
//    func authenticationViewController(
//        _ viewController: UIViewController,
//        authorizedWith token: String?) {
//        
//        guard let key = token else { return }
//        Credential().saveTokenInKeychain(key)
//        
//        print("This")
//        
//        //TODO: сделать переход на главный экран
//        
////        let mainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController")
////        viewController.present(mainViewController, animated: true, completion: nil)
//    }
//}
//
////TODO: убрать активити индикатор
