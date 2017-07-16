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
    
    static func performArrayRequest<T: Mappable>(type: T, target: JsonPlaceholder) -> Observable<NetworkResult> {
        return provider
            .request(target)
            .flatMapLatest { (response) -> Observable<NetworkResult> in
                let json = JSON(data: response.data)
                let jsonString = String(describing: json)
                guard let posts = Mapper<T>().mapArray(JSONString: jsonString) else {
                    return just(NetworkResult.fail(error:ErrorType.mapping))
                }
                return just(NetworkResult.arraySuccess(array: posts))
            }
            .catchErrorJustReturn(NetworkResult.fail(error: ErrorType.network))
    }
    
}

extension NetworkProvider {
    
    static func performStubRequest<T: Mappable>(type: T, target: JsonPlaceholder, complete: @escaping (Observable<NetworkResult>) -> ())  {
        let endpoint = provider.endpoint(target)
        
        provider.stubRequest(target, request: endpoint.urlRequest!, completion: { (result) in
            let resultO = Observable<Response>.create { observer in
                switch result {
                case let .success(response):
                    observer.onNext(response)
                    observer.onCompleted()
                case let .failure(error):
                    observer.onError(error)
                }
                
                return Disposables.create()
            }.flatMapLatest({ (response) -> Observable<NetworkResult> in
                let json = JSON(data: response.data)
                let jsonString = String(describing: json)
                guard let posts = Mapper<T>().mapArray(JSONString: jsonString) else {
                    return just(NetworkResult.fail(error:ErrorType.mapping))
                }
                return just(NetworkResult.arraySuccess(array: posts))

            })
            complete(resultO)
        }, endpoint: endpoint, stubBehavior: StubBehavior.immediate)
        
    }
    
}
