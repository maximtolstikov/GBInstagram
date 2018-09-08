// Для описания контроллера TagResultDetailController

import UIKit

class TagResultDetailController: UIViewController, TagResultDetailView {
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    var output: TagResultDetailViewOutput?
    var dataForImageView: Data? {
        didSet {
            DispatchQueue.main.async {
                //swiftlint:disable force_unwrapping
                self.imageView.image = UIImage(data: self.dataForImageView!)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output?.loadImage()
        
    }
    
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
}
