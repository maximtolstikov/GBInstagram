// Для описания интерфейса к api запросам
// для контроллера Публикаций

protocol PublicationDataProvider {
    
    func getMediaOfUser(completion: @escaping (String) -> Void)
    func searchTag(completion: @escaping (String) -> Void)
    func getPhotoForTag(_ tag: Tag, _ completion: @escaping (String) -> Void)
}
