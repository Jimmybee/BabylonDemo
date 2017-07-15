//
//  PostService.swift
//  BabylonPosts
//
//  Created by James Birtwell on 12/07/2017.
//  Copyright © 2017 James Birtwell. All rights reserved.
//

import Foundation
import RxSwift

class PostService {
    
    static let target = JsonPlaceholder.posts
    
    static func get() -> Observable<NetworkResult> {
        return NetworkProvider.performArrayRequest(type: Post(), target: target)
    }
}

