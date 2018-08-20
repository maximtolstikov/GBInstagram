// Для определения модели пользователя

struct User {
    
    let identifier: Int
    let userName: String
    let avatarImageURLString: String
    let fullName: String
}

extension User {
    
    //swiftlint:disable force_cast force_unwrapping
    init(dictionary: [String: Any]) {
        self.init(identifier: Int(dictionary["id"] as! String)!,
                  userName: dictionary["username"] as! String,
                  avatarImageURLString: dictionary["profile_picture"] as! String,
                  fullName: dictionary["full_name"] as! String)
    }
    
}
