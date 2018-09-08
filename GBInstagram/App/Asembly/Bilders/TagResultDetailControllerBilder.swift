// Для строительства котнроллера TagResultDetailController

import UIKit

class TagResultDetailControllerBilder {
    
    
    //swiftlint:disable force_cast
    func viewController(with url: String) -> UIViewController {
        
        let tagResultDetailController = UIStoryboard(
            name: "Main",
            bundle: nil)
            .instantiateViewController(
                withIdentifier: "TagResultDetailController") as! TagResultDetailController
        
        let presenter = TagResultDetailPresenter()
        presenter.dataProvider = InstagramTagResultDetailDataProvider()
        presenter.view = tagResultDetailController
        presenter.imageUrl = url
        
        tagResultDetailController.output = presenter
        
        return tagResultDetailController
    }
    
}
