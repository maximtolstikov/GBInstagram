// Для описания модели Тэга

import SwiftyJSON

struct Tag {
    
    var mediaCount: Int
    var name: String
}

extension Tag {
    
    init(json: JSON) {
        self.mediaCount = json["media_count"].intValue
        self.name = json["name"].stringValue
    }
}
