// Для определения модели пользователя

import SwiftyJSON

struct User {
    
    var identifier: Int
    var userName: String
    var avatarImageURLString: String
    var fullName: String
}

extension User {
    
    init(json: JSON) {
        self.identifier = json["id"].intValue
        self.userName = json["username"].stringValue
        self.avatarImageURLString = json["profile_picture"].stringValue
        self.fullName = json["full_name"].stringValue
    }
    
}
