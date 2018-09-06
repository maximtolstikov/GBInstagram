// Для описания контроллера Поиска по тегам

import UIKit

// swiftlint:disable:next private_over_fileprivate
@objc(_TagSearchControllerSnapshot) fileprivate class TagSearchControllerSnapshot: NSObject, Snapshot {
    
    let identifier: String
    let inputText: String?
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(identifier, forKey: "identifire")
        aCoder.encode(inputText, forKey: "inputText")
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        
        guard let identifier = aDecoder.decodeObject(forKey: "identifire") as? String else { return nil }
        
        self.inputText = aDecoder.decodeObject(forKey: "inputText") as? String
        self.identifier = identifier
    }
    
    
    init(identifire: String, inputText: String) {
        
        self.identifier = identifire
        self.inputText = inputText
    }
}


class TagSearchController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let identifireSnapshot = "TagSearchControllerSnapshot"
    var dataProvider: TagSearchDataProvider!
    var snapshotManager: SnapshotManager!
    var tagList = [Tag]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
        setTextInSearchBar()
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
        searchBar.text = snapshot.inputText
        //swiftlint:disable:next force_unwrapping
        getDataFromServer(for: snapshot.inputText!)
    }
    
    
    // Создает снапшот
    private func createSnapshot(for text: String) -> Snapshot {
        
        return TagSearchControllerSnapshot(identifire: identifireSnapshot, inputText: text)
    }
    
    
    // Получает данные по введенному тексту
    func getDataFromServer(for text: String) {
        
        dataProvider.getTags(with: text) { [weak self] (tags) in
            
            self?.tagList = tags
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
            
        }
    }
    
}


extension TagSearchController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "TagSearchCell",
            for: indexPath) as! TagSearchCell
        
        cell.leftLable.text = tagList[indexPath.row].name
        
        return cell
    }
    
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
        return tagList.count
    }
}


extension TagSearchController: UISearchBarDelegate {
    
    
    func searchBar(
        _ searchBar: UISearchBar,
        textDidChange searchText: String) {
        
        guard searchText != "" else { return }
        
        let snapshot = createSnapshot(for: searchText.lowercased())
        snapshotManager.save(snapshot: snapshot)
        
        getDataFromServer(for: searchText.lowercased())
    }
    
}
