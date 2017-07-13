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
    
    let target = JsonPlaceholder.posts
    
    func get() -> Observable<JsonResult> {
        return JsonNetwork.performArrayRequest(type: Post(), target: target)
    }
}

