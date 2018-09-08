// Для описания презентера в MVP

import Foundation

class TagSearchPresenter: TagSearchViewOutput {
    
    let identifireSnapshot = "TagSearchControllerSnapshot"
    
    var dataProvider: TagSearchDataProvider!
    var snapshotManager: SnapshotManager!
    weak var view: TagSearchView!
    var searchResult: [Tag]?
    var tagSearchResultControllerBilder: TagSearchResultControllerBilder!
    
    
    // Вызывает переход в сответствии с выбраным тэгом
    func didSelectItem(with identifier: String) {
        
        guard let tag = searchResult?.first(where: {
            $0.name == identifier
        }) else { return }
        
        view.moveTo(
            viewController: tagSearchResultControllerBilder
                .viewController(for: tag))
        
    }
    
    
    // Обрабатывает запрос из SearchBar
    func didChangeQuery(to query: String?) {
        
        guard let query = query else {
            view.searchResult = nil
            self.searchResult = nil
            return
        }
        
        let snapshot = createSnapshot(for: query)
        snapshotManager.save(snapshot: snapshot)
        
        getDataFromServer(for: query)
        
    }
    
    
    // Получает данные по введенному тексту
    private func getDataFromServer(for text: String) {
        
        dataProvider.getTags(with: text) { [weak self] (tags) in
            
            self?.searchResult = tags
            self?.view.searchResult = tags.compactMap({
                self?.cellModel(for: $0)
            })
        }
        
    }
    
    
    // Создает модель для передачи в контроллер
    func cellModel(for tag: Tag) -> TagSearchCellModel {
        
        return TagSearchCellModel(title: tag.name, identifier: tag.name)
        
    }
    
    
    // Заполняет searchBar если данные имеются
    func setTextInSearchBar() {
        
        guard let snapshot = snapshotManager.snapshot(
            with: identifireSnapshot) else { return }
        restore(snapshot: snapshot)
        
    }
    
    
    // Восстанавливает прежнее состояние из снапшота
    private func restore(snapshot: Snapshot) {
        
        guard let snapshot = snapshot as? TagSearchControllerSnapshot,
            snapshot.inputText != nil else { return }

        //swiftlint:disable:next force_unwrapping
        getDataFromServer(for: snapshot.inputText!)
        view.query = snapshot.inputText
        
    }
    
    
    // Создает снапшот
    private func createSnapshot(for text: String) -> Snapshot {
        
        return TagSearchControllerSnapshot(
            identifire: identifireSnapshot,
            inputText: text)
        
    }

}


// Для описания класса Snapshot

// swiftlint:disable:next private_over_fileprivate
@objc(_TagSearchControllerSnapshot) fileprivate class TagSearchControllerSnapshot: NSObject,
                                                                                   Snapshot {
    
    let identifier: String
    let inputText: String?
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(identifier, forKey: "identifire")
        aCoder.encode(inputText, forKey: "inputText")
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        
        guard let identifier = aDecoder
            .decodeObject(forKey: "identifire") as? String else { return nil }
        
        self.inputText = aDecoder.decodeObject(forKey: "inputText") as? String
        self.identifier = identifier
    }
    
    
    init(identifire: String, inputText: String) {
        
        self.identifier = identifire
        self.inputText = inputText
    }
}
