// Для настройки WKWebView авторизации

import UIKit
import WebKit

class AuthenticationViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    
    var router: AuthenticationRouter?
    var device: DeviceType = .iPhone

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: - закрыть методы APIManager для контроллера
        guard let request = APIManager.getAuthenticationRequest() else {
            print("Request is nil!")
            return
        }
        
        webView.navigationDelegate = self
        removeCache()
        webView.load(request)
    }
    
    
    // Удаляем cache
    func removeCache() {
        let dataStore = WKWebsiteDataStore.default()
        dataStore.fetchDataRecords(
        ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { (records) in
            for record in records {
                dataStore.removeData(
                    ofTypes: record.dataTypes,
                    for: [record],
                    completionHandler: {}
                )
            }
        }
    }
    
}

extension AuthenticationViewController: WKNavigationDelegate {
    
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationAction: WKNavigationAction,
        decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        guard let urlString = navigationAction.request.url?.absoluteString
            else {
                decisionHandler(.allow)
                return
        }
        
        guard urlString.range(of: "#access_token") != nil else {
            decisionHandler(.allow)
            return
        }
        
        if let accessToken = urlString.components(separatedBy: "#access_token=")
            .last {            
            Credential().saveTokenInKeychain(accessToken)
        }
        
        switch device {
        case .iPhone:
            router = AuthenticationIphoneRouter(veiwController: self)
        case .iPad:
            router = AuthenticationIpadRouter(veiwController: self)
        }
        
        router?.navigateAuthSuccess()
        decisionHandler(.cancel)
    }
}
