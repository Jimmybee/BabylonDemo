//
//  NetworkProvider.swift
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

class NetworkProvider {
    
    static let provider = RxMoyaProvider<JsonPlaceholder>()
    
    static func performArrayRequest<T: Mappable>(with mapper: Mapper<T>, target: JsonPlaceholder) -> Observable<NetworkResult> {
        return provider
            .request(target)
            .flatMapLatest { (response) -> Observable<NetworkResult> in
                let json = JSON(data: response.data)
                let jsonString = String(describing: json)
                guard let posts = mapper.mapArray(JSONString: jsonString) else {
                    return just(NetworkResult.fail(error:ErrorType.mapping))
                }
                return just(NetworkResult.arraySuccess(array: posts))
            }
            .catchErrorJustReturn(NetworkResult.fail(error: ErrorType.network))
    }
    
}

