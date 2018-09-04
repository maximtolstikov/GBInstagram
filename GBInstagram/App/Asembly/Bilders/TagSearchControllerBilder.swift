// Для строительства контроллера TagSearch

import UIKit

class TagSearchControllerBilder {
    
    
    //swiftlint:disable force_cast
    func viewController() -> UIViewController {
        
        let tagSearchController = UIStoryboard(
            name: "Main",
            bundle: nil)
            .instantiateViewController(
                withIdentifier: "TagSearchController") as! TagSearchController
        
        tagSearchController.dataProvider = InstagramTagSearchDataProvider()
        tagSearchController.snapshotManager = DefaultSnapshotManaget(
            userId: getUserIdFromUserDefaults())
        
        return tagSearchController
    }
    
    private func getUserIdFromUserDefaults() -> Int {
        
        let userDefaults = UserDefaults.standard
        return userDefaults.integer(forKey: "instagramUserId")
    }
}
