// Для описания TagSearchResultController

import UIKit

private let reuseIdentifier = "TagSearchResultCell"

class TagSearchResultController: UIViewController,
                                 UICollectionViewDataSource,
                                 UICollectionViewDelegate,
                                 TagSearchResultView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var output: TagSearchResultViewOutput?
    var dataForCell = [TagSearchResultCellModel]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        output?.loadPublications()

    }

    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {

        return dataForCell.count
    }

    //swiftlint:disable force_cast
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: reuseIdentifier,
            for: indexPath) as! TagSearchResultCell

        let data = dataForCell[indexPath.row].thumbnail
        cell.imageViewCell.image = UIImage(data: data)
        cell.backgroundColor = UIColor.cyan
        
        return cell
    }
    
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath) {
        
        output?.didSelectItem(with: dataForCell[indexPath.row].id)
        
    }
    
    func moveTo(viewController: UIViewController) {
        present(viewController, animated: true, completion: nil)
    }

    @IBAction func backButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}
