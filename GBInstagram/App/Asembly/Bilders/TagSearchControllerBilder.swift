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
        
        let presenter = TagSearchPresenter()
        presenter.dataProvider = InstagramTagSearchDataProvider()
        presenter.snapshotManager = DefaultSnapshotManaget(
            userId: getUserIdFromUserDefaults())
        presenter.view = tagSearchController
        presenter.tagSearchResultControllerBilder = TagSearchResultControllerBilder()
        
        tagSearchController.output = presenter
        
        return tagSearchController
    }
    
    
    // Получает userId из UserDefaults
    private func getUserIdFromUserDefaults() -> Int {
        
        let userDefaults = UserDefaults.standard
        return userDefaults.integer(forKey: "instagramUserId")
    }
}
