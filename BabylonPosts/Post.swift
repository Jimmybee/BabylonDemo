//
//  Post.swift
//  BabylonPosts
//
//  Created by James Birtwell on 11/07/2017.
//  Copyright © 2017 James Birtwell. All rights reserved.
//



import Foundation
import ObjectMapper
import RxSwift

class Post: Mappable {
    
    var userId: Int?
    var id: Int?
    var title: String?
    var body: String?
    
    init() {}
    
    required init?(map: Map) {}
    
    convenience init(_ postRealm: PostRealm) {
        self.init()
        self.userId = postRealm.userId
        self.id = postRealm.id
        self.title = postRealm.title
        self.body = postRealm.body
    }
    
    func mapping(map: Map) {
        userId <- (map["userId"], IntTransform())
        id <- (map["id"], IntTransform())
        title <- map["title"]
        body <- map["body"]

    }
    
}



