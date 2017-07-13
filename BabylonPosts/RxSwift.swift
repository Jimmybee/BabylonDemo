//
//  RxSwift.swift
//  BabylonPosts
//
//  Created by James Birtwell on 12/07/2017.
//  Copyright © 2017 James Birtwell. All rights reserved.
//

import Foundation
import RxSwift

func just<E>(_ element: E) -> Observable<E> {
    return Observable.create { observer in
        observer.on(.next(element))
        observer.on(.completed)
        return Disposables.create()
    }
}
