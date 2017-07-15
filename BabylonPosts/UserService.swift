//
//  UserService.swift
//  BabylonPosts
//
//  Created by James Birtwell on 12/07/2017.
//  Copyright © 2017 James Birtwell. All rights reserved.
//

import Foundation
import RxSwift

class UserService {
    
    static let target = JsonPlaceholder.users
    
    static func get() -> Observable<NetworkResult> {
        return NetworkProvider.performArrayRequest(type: User(), target: target)
    }
}
