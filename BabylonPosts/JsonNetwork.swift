//
//  JsonNetwork.swift
//  BabylonPosts
//
//  Created by James Birtwell on 11/07/2017.
//  Copyright © 2017 James Birtwell. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON
import ObjectMapper
import RxSwift

class JsonNetwork {
    
    static let provider = RxMoyaProvider<JsonPlaceholder>()
    
    static func performArrayRequest<T: Mappable>(type: T, target: JsonPlaceholder) -> Observable<JsonResult> {
        return provider
            .request(target)
            .flatMapLatest { (response) -> Observable<JsonResult> in
                let json = JSON(data: response.data)
                let jsonString = String(describing: json)
                guard let posts = Mapper<T>().mapArray(JSONString: jsonString) else {
                    return just(JsonResult.fail(error:ErrorType.mapping))
                }
                return just(JsonResult.arraySuccess(array: posts))
            }
            .catchErrorJustReturn(JsonResult.fail(error: ErrorType.network))
    }
    
}


enum JsonResult {
    case fail(error: ErrorType)
    case arraySuccess(array: [Mappable])
}
