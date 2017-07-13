//
//  User.swift
//  BabylonPosts
//
//  Created by James Birtwell on 11/07/2017.
//  Copyright © 2017 James Birtwell. All rights reserved.
//

import Foundation
import ObjectMapper

class User: Mappable {
    
    var id: Int?
    var name: String?
    
    
    init() {}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- (map["id"], IntTransform())
        name <- map["name"]
        
    }
}
