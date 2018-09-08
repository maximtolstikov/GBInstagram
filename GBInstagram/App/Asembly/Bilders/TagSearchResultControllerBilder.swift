// Для строительства котнроллера TagSearchResultController

import UIKit

class TagSearchResultControllerBilder {
    
    
    //swiftlint:disable force_cast
    func viewController(for tag: Tag) -> UIViewController {
        
        let tagSearchResultController = UIStoryboard(
            name: "Main",
            bundle: nil)
            .instantiateViewController(
                withIdentifier: "TagSearchResultController") as! TagSearchResultController
        
        let presenter = TagSearchResultPresenter()
        presenter.dataProvider = InstagramTagSearchResultDataProvider()
        presenter.view = tagSearchResultController
        presenter.tag = tag
        presenter.tagResultDetailControllerBilder = TagResultDetailControllerBilder()
        
        tagSearchResultController.output = presenter
        
        return tagSearchResultController
    }
    
}
