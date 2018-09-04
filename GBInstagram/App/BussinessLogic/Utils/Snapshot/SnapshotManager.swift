// Для описания интерфейса SnapshotManager

protocol SnapshotManager {
    
    func snapshot(with identifier: String) -> Snapshot?
    func save(snapshot: Snapshot)
}
