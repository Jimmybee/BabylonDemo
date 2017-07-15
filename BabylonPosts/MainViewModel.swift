//
//  MainViewModel.swift
//  BabylonPosts
//
//  Created by James Birtwell on 15/07/2017.
//  Copyright © 2017 James Birtwell. All rights reserved.
//

import Foundation
import RxSwift
import RxOptional

class MainViewModel {
    
    let disposeBag = DisposeBag()
    var handleError: ((NetworkResult?) ->())?
    let posts = Variable<[Post]>([])
    
    init() {
        loadRealm()
    }
    
    /// Loads any persistent realm posts on model initialisation
    fileprivate func loadRealm() {
        posts.value = Array(PostRealm.get()).map({Post($0)})
    }

    /// Gets latests posts from server.
    /// Saves posts to realm. Overwriting any previous posts.
    /// Updates posts in local model.
    func updatePosts() {
        PostService.get().map { [weak self] (result) -> [Post]? in
            if result.hasError {
                self?.handleError?(result)
                return nil
            } else {
                guard let posts = result.successObject() as? [Post] else {
                    self?.handleError?(nil)
                    return nil
                }
                PostRealm.saveAll(posts: posts, completion: {})
                return posts
            }
            }
            .filterNil()
            .bindTo(posts)
            .addDisposableTo(disposeBag)
    }
    
    /// Gets comments and users from server
    /// Waits for both requests to complete.
    /// If both error, only handles first error.
    /// Gets author from users based on user Id.
    /// Gets comments from comments based on post Id.
    /// - parameter post: The post to view in detail.
    /// - returns: A detail view model with post, post author and post comments.
    func detailModelFor(post: Post) -> Observable<DetailViewModel> {
        let commentRequest = CommentService.get()
        let userRequest = UserService.get()
        return Observable.zip(commentRequest, userRequest) { [weak self] (commentResult, userResult) -> DetailViewModel? in
            if commentResult.hasError || userResult.hasError {
                let firstError = [commentResult, userResult].filter({$0.hasError}).first
                self?.handleError?(firstError)
                return nil
            } else {
                guard let comments = commentResult.successObject() as? [Comment] else {
                    self?.handleError?(nil)
                    return nil
                }
                guard let users = userResult.successObject() as? [User] else {
                    self?.handleError?(nil)
                    return nil
                }
                let author = users.filter({$0.id == post.userId}).first?.name ?? "Unknown Author"
                return DetailViewModel(post: post, author: author, comments: comments)
            }
            }.filterNil()
    }
    
}
