// Для описания реализации SnapshotManager

import Foundation

class DefaultSnapshotManaget: SnapshotManager {

    
    var userId: Int
    let userDefaults = UserDefaults.standard
    
    init(userId: Int) {
        self.userId = userId
    }
    
    
    // Получает снапшот
    func snapshot(with identifier: String) -> Snapshot? {
        
        guard let data = userDefaults.object(
            forKey: storageKey(
                identifier: identifier,
                userId: userId)) as? Data else { return nil }
        
        return NSKeyedUnarchiver.unarchiveObject(with: data) as? Snapshot
    }
    
    
    // Сохраняет снапшот
    func save(snapshot: Snapshot) {
        
        let dataToStore = NSKeyedArchiver.archivedData(withRootObject: snapshot)
        userDefaults.set(
            dataToStore,
            forKey: storageKey(
                identifier: snapshot.identifier,
                userId: userId
            )
        )
    }
    
    
    // Создает уникальный идентификатор для ключа
    func storageKey(identifier: String, userId: Int) -> String {
        
        return "snapshot" + identifier + String(userId)
    }
}
