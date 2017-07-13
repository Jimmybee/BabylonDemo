//
//  ViewController.swift
//  BabylonPosts
//
//  Created by James Birtwell on 11/07/2017.
//  Copyright © 2017 James Birtwell. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxOptional

class ViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    @IBOutlet weak var postTable: UITableView!
    @IBOutlet weak var refreshBttn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindUI()
        loadRealm()
        refreshTable()
        setupTap()
        
    }
    
    let posts = Variable<[Post]>([])
    
    var commentsO: Observable<[Comment]>  {
        return CommentService().get().map { [weak self] (result) -> [Comment]? in
            switch result {
            case .arraySuccess(array: let result):
                let comments = result as! [Comment]
                return comments
            case .fail(error: let errorType):
                self?.present(errorType.alert, animated: true, completion: nil)
                return nil
            }
        }
        .filterNil()
        .shareReplay(1)
    }
    
    var usersO: Observable<[User]>  {
        return UserService().get().map { (result) -> [User]? in
            switch result {
            case .arraySuccess(array: let result):
                let users = result as! [User]
                return users
            case .fail(error: _):
                return nil
            }
        }
        .filterNil()
        .shareReplay(1)
    }

}


extension ViewController {
    
    func bindUI() {
        posts.asObservable()
            .bindTo(postTable
                .rx
                .items(cellIdentifier: "Cell",
                       cellType: UITableViewCell.self)) {
                        row, post, cell in
                        cell.textLabel?.text = post.title
            }
            .addDisposableTo(disposeBag)
    }
    
    func loadRealm() {
        posts.value = Array(PostRealm().get()).map({Post($0)})
    }
    
    func refreshTable() {
        
        refreshBttn.rx.tap
            .startWith(())
            .flatMapLatest({ (_) -> Observable<JsonResult> in
                return PostService().get()
            })
            .map({  [weak self]  (result) -> [Post]? in
                switch result {
                case .arraySuccess(array: let result):
                    let posts = result as! [Post]
                    PostRealm().save(posts: posts, completion: {})
                    return posts
                case .fail(error: let errorType):
                    self?.present(errorType.alert, animated: true, completion: nil)
                    return nil
                }
            })
            .filterNil()
            .bindTo(posts)
            .addDisposableTo(disposeBag)
        
    }
    
    func setupTap() {
        postTable.rx
            .modelSelected(Post.self)
            .subscribe(onNext: { [weak self] (post) in
                self?.showPostDetail(post)
            })
            .addDisposableTo(disposeBag)
        
        postTable.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.postTable.deselectRow(at: indexPath, animated: true)
            }).addDisposableTo(disposeBag)

    }
    
}

// MARK: Navigation
extension ViewController {
    
    func showPostDetail(_ post: Post) {
        Observable.combineLatest(usersO, commentsO) { (users, comments) -> DetailModel in
            let user = users.filter({$0.id == post.userId}).first
            let comments = comments.filter({$0.postId == post.id})
            return DetailModel(post: post, author: user?.name ?? "", comments: comments)
        }.subscribe(onNext: { [weak self] (model) in
            let detailController = DetailViewController.storyboardInit(detailModel: model)
            self?.navigationController?.pushViewController(detailController, animated: true)
        }).addDisposableTo(disposeBag)
    }
    
}







