// Для описания контроллера Поиска по тегам

import UIKit

class TagSearchController: UIViewController, TagSearchView {
   
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var output: TagSearchViewOutput!
    var query: String? {
        didSet {
            searchBar.text = query
        }
    }
    var searchResult: [TagSearchCellModel]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
        output.setTextInSearchBar()
        
    }
    
    
    // Переходит на переданный viewController
    func moveTo(viewController: UIViewController) {
        present(viewController, animated: true, completion: nil)
    }
   
}


extension TagSearchController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let item = searchResult?[indexPath.row] else {
            assertionFailure()
            return UITableViewCell()
        }
        
        //swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "TagSearchCell",
            for: indexPath) as! TagSearchCell
        
        cell.leftLable.text = item.title
        
        return cell
    }
    
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
        
        return searchResult?.count ?? 0
        
    }
    
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath) {
        
        guard let item = searchResult?[indexPath.row] else {
            assertionFailure()
            return
        }
        
        output.didSelectItem(with: item.identifier)
        
    }
    
}


extension TagSearchController: UISearchBarDelegate {
    
    
    // Выполняется по введению символа в SearchBar
    func searchBar(
        _ searchBar: UISearchBar,
        textDidChange searchText: String) {
        
        guard searchText != "" else { return }
        
        output.didChangeQuery(to: searchText.lowercased())
        
        
    }
    
}
