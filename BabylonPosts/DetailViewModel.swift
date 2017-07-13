//
//  DetailViewModel.swift
//  BabylonPosts
//
//  Created by James Birtwell on 13/07/2017.
//  Copyright © 2017 James Birtwell. All rights reserved.
//

import Foundation


struct DetailViewModel {
    
    var post: Post
    var comments: [Comment]
    var author: String
    
    init(post: Post, author: String, comments: [Comment]) {
        self.post = post
        self.author = author
        self.comments = comments
    }
    
}
