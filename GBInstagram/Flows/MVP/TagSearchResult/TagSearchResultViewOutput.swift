// Для описания интерфейса доступа к TagSearchResultPresentor

protocol TagSearchResultViewOutput {
    
    func loadPublications()
    func didSelectItem(with urlString: String)
    
}
