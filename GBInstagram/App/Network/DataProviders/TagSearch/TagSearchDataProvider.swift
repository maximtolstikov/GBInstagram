// Для описания интерфейса к api для контроллера Поиска по тегам

protocol TagSearchDataProvider {
    
    func getTags(with tag: String, completion: @escaping ([Tag]) -> Void)
}
