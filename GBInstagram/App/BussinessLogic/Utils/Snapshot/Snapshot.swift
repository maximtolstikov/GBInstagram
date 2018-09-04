// Для описания интерфейса объекта Snapshot

import Foundation

protocol Snapshot: NSCoding {

    var identifier: String { get }
}
