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
    
    static let target = JsonPlaceholder.comments
    
    static func get() -> Observable<NetworkResult> {
        return NetworkProvider.performArrayRequest(type: Comment(), target: target)
    }
    
}
