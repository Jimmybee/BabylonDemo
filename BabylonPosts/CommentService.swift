//
//  CommentService.swift
//  BabylonPosts
//
//  Created by James Birtwell on 12/07/2017.
//  Copyright © 2017 James Birtwell. All rights reserved.
//

import Foundation
import RxSwift

class CommentService {
    
    let target = JsonPlaceholder.comments
    
    func get() -> Observable<JsonResult> {
        return JsonNetwork.performArrayRequest(type: Comment(), target: target)
    }
    
}
