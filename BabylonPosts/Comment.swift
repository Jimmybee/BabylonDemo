//
//  Comment.swift
//  BabylonPosts
//
//  Created by James Birtwell on 11/07/2017.
//  Copyright © 2017 James Birtwell. All rights reserved.
//


import Foundation
import ObjectMapper

class Comment: Mappable {
    
    var postId: Int?
    var id: Int?
    var name: String?
    var email: String?
    var body: String?

    
    init() {}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        postId <- (map["postId"], IntTransform())
        id <- (map["id"], IntTransform())
        name <- map["title"]
        email <- map["email"]
        body <- map["body"]
        
    }
}
