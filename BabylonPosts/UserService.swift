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
    
    let target = JsonPlaceholder.users
    
    func get() -> Observable<JsonResult> {
        return JsonNetwork.performArrayRequest(type: User(), target: target)
    }
}
