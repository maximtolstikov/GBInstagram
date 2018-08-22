// Для настройки WKWebView авторизации

import UIKit
import WebKit

class AuthViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var wkWebView: WKWebView!
    
    var router: AuthenticationRouter?
    
    let clientId = "efde2e1af6b24b339b2654cd1660558f"
    let redirectURL = "https://www.instagram.com"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(
            string: "https://api.instagram.com/oauth/authorize/?client_id=\(clientId)&redirect_uri=\(redirectURL)&response_type=token"
            ) else { return }
        
        let request = URLRequest(
            url: url,
            cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
            timeoutInterval: 10.0
        )
        
        wkWebView.navigationDelegate = self
        removeCache()
        wkWebView.load(request)
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

extension AuthViewController: WKNavigationDelegate {
    
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
        
        if let accessToken = urlString.components(
            separatedBy: "#access_token=").last {
            
            Credential().saveTokenInKeychain(accessToken)
        }
        
        router = AuthenticationDefaultRouter(veiwController: self)        
        router?.navigateAuthSuccess()
        
        decisionHandler(.cancel)
    }
}
