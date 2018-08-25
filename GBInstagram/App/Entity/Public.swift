// Для описания модели фотографий

import SwiftyJSON

struct Public {
    
    var id: String
    var user: User
    var images: Images
    var createdTime: String
    
    init(json: JSON) {
        self.id = json["id"].stringValue
        self.images = Images(json: json["images"])
        self.user = User(json: json["user"])
        self.createdTime = json["created_time"].stringValue
    }
    
}


struct Images {
    
    var thumbnail: Photo
    var lowResolution: Photo
    var standardResolution: Photo
    
    init(json: JSON) {
        self.thumbnail = Photo(json: json["thumbnail"])
        self.lowResolution = Photo(json: json["low_resolution"])
        self.standardResolution = Photo(json: json["standard_resolution"])
    }
}


struct Photo {
    
    var width: Int
    var height: Int
    var url: String
    
    init(json: JSON) {
        self.width = json["width"].intValue
        self.height = json["height"].intValue
        self.url = json["url"].stringValue
    }
}
