//
//  NetworkResult.swift
//  BabylonPosts
//
//  Created by James Birtwell on 15/07/2017.
//  Copyright © 2017 James Birtwell. All rights reserved.
//

import Foundation
import ObjectMapper

enum NetworkResult {
    case fail(error: ErrorType)
    case arraySuccess(array: [Mappable])
    
    var hasError: Bool {
        switch self {
        case .arraySuccess(_):
            return false
        case .fail(_):
            return true
        }
    }
    
    func successObject() -> [Mappable]? {
        if case .arraySuccess(let value) = self {
            return value
        }
        return .none
    }
}
