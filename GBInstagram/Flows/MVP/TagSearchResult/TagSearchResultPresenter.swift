// Для настройки презентера для TagSearchResultController

import UIKit

class TagSearchResultPresenter: TagSearchResultViewOutput {
    
    var publications = [Public]()
    var dataProvider: TagSearchResultDataProvider!
    weak var view: TagSearchResultView!
    var tag: Tag!
    var tagResultDetailControllerBilder: TagResultDetailControllerBilder!
    
    
    // Загружает публикации
    func loadPublications() {
        
        view.dataForCell.removeAll()
        
        dataProvider.getPublics(with: tag.name) { [weak self] (publics) in
            self?.publications = publics
            self?.createDataForCell(publications: publics)
        }
        
    }
    
    
    // Получаем изображения и формируем модель для передачи в контроллер
    func createDataForCell(publications: [Public]) {
        
        guard !publications.isEmpty else {
            return
        }
        
        for publication in publications {
            let url = publication.images.thumbnail.url
            dataProvider.getImage(urlString: url) { [weak self] (data) in
                
                guard data != nil else { return }
                
                //swiftlint:disable force_unwrapping
                let model = TagSearchResultCellModel(
                    id: publication.id,
                    thumbnail: data!,
                    standartResolution: publication.images.standardResolution.url
                )
                self?.view.dataForCell.append(model)
               
            }
        }
        
    }
    
    
    // Действия при выборе публикации
    func didSelectItem(with identifier: String) {
        guard let publication = publications.first(where: {
            $0.id == identifier
        }) else { return }
        
        view.moveTo(
            viewController: tagResultDetailControllerBilder
                .viewController(with: publication.images.standardResolution.url))

    }
    
}
