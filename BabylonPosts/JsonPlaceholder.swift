//
//  JsonPlaceholder.swift
//  BabylonPosts
//
//  Created by James Birtwell on 11/07/2017.
//  Copyright © 2017 James Birtwell. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON

enum JsonPlaceholder {
    case posts
    case users
    case comments
}

extension JsonPlaceholder: TargetType {
    
    var baseURL: URL { return URL(string: "https://jsonplaceholder.typicode.com")! }
   
    var path: String {
        switch self {
        case .posts:
            return "/posts"
        case .users:
            return "/users"
        case .comments:
            return "/comments"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var parameters: [String: Any]? {
        return nil
    }
    
    var sampleData: Data {
            return "{{\"Implemented\": \"Nope\"}}".data(using: .utf8)!
    }
    
    var task: Task {
        return .request
    }
    
    var parameterEncoding: ParameterEncoding {
            return URLEncoding.default
    }
}
