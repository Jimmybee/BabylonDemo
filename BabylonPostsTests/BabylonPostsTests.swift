//
//  BabylonPostsTests.swift
//  BabylonPostsTests
//
//  Created by James Birtwell on 15/07/2017.
//  Copyright © 2017 James Birtwell. All rights reserved.
//

@testable import BabylonPosts
import XCTest
import RxSwift
import RxTest
import Moya

class BabylonPostsTests: XCTestCase {

    let disposeBag = DisposeBag()

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()

    }
    
    func testProvider() {
        let scheduler = TestScheduler(initialClock: 0)
        let model = MainViewModel()
        
        let tap = scheduler.createHotObservable([
            next(200, 2),
            ])
        
        NetworkProvider.performStubRequest(type: Post(), target: .posts) { (resultO) in
            resultO.subscribe(onNext: { (result) in
                switch result {
                case .arraySuccess(array: let successObjects):
                    let count = successObjects.count
                    XCTAssertTrue(count == 4)
                    model.posts.value = successObjects as! [Post]
                case .fail(error: _):
                    XCTFail("Stub fail")
                    break
                }
            })
            .addDisposableTo(self.disposeBag)

        }
        
        tap.map { (index) -> Post in
            return model.posts.value[index]
        }.subscribe(onNext: { (post) in
            XCTAssertFalse(post.id == 0)
            XCTAssertTrue(post.title == "ea molestias quasi exercitationem repellat qui ipsa sit aut")
        }).addDisposableTo(disposeBag)
        
        scheduler.start()
        

    }
    
    
}
