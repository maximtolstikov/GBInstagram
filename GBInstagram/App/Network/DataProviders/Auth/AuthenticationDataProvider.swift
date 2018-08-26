// Для определения интерфейса к api запросам для
// контроллера авторизации

import UIKit

protocol AuthenticationDataProvider {
    
    func getAuthenticationRequest() -> URLRequest?
}
