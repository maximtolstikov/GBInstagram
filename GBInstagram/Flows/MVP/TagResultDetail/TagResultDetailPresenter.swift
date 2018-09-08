// Для настройки презентера для TagResultDetailController

class TagResultDetailPresenter: TagResultDetailViewOutput {
    
    var view: TagResultDetailView?
    var dataProvider: TagResultDetailDataProvider?
    var imageUrl: String!
    
    
    // загружает и передает изображение в контроллер
    func loadImage() {
        
        dataProvider?.getImage(urlString: imageUrl, completion: { (data) in
            
            guard data != nil else {
                assertionFailure()
                return
            }
            
            self.view?.dataForImageView = data
            
        })
        
    }
    
}
