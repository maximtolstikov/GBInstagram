// Интерфейс для вызова Презентера из Вью

protocol SearchViewOutput {
    
    func didSelectItem(with identifier: String)
    func didChangeQuery(to query: String?)
    func setTextInSearchBar()
    
}
