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

class MainViewController: UIViewController {
    
    @IBOutlet weak var postTable: UITableView!
    @IBOutlet weak var refreshBttn: UIBarButtonItem!
    
    fileprivate let disposeBag = DisposeBag()
    fileprivate let mainViewModel = MainViewModel()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainViewModel.handleError = handleError
        
        bindUI()
        setupRefreshPosts()
        setupTap()
    }
}


//MARK: - RxSwift setup
extension MainViewController {
    
    /// Binds posts to tableview
    fileprivate func bindUI() {
        mainViewModel.posts.asObservable()
            .bindTo(postTable
                .rx
                .items(cellIdentifier: "Cell",
                       cellType: UITableViewCell.self)) {
                        row, post, cell in
                        cell.textLabel?.text = post.title
            }
            .addDisposableTo(disposeBag)
    }
    
    /// On subscribe and on every following tap, view model is updated with latest posts from the server.
    fileprivate func setupRefreshPosts() {
        refreshBttn.rx.tap
            .startWith(())
            .subscribe(onNext: { [weak self] (_) in
                self?.mainViewModel.updatePosts()
            })
            .addDisposableTo(disposeBag)
    }
    
   /// Tapping a cell on the table with initiate showing the post detail, and unselect the row.
   fileprivate func setupTap() {
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

// MARK: Private functions
extension MainViewController {
    
    /// Displays an alert controller depending on any errors.
    fileprivate func handleError(_ result: NetworkResult?) -> () {
        guard let result = result else { return }
        switch result {
        case .fail(error: let type):
            present(type.alert, animated: true, completion: nil)
        default:
            present(UIAlertController.defaultError(), animated: true, completion: nil)
        }
    }
    
}

// MARK: Navigation
extension MainViewController {
    
    /// Builds a detail view model containing the post, author and comments.
    /// Injects view model in to DetailViewController
    /// Pushes DetailViewController on to navigation stack
    fileprivate func showPostDetail(_ post: Post) {
        mainViewModel.detailModelFor(post: post)
            .subscribe(onNext: { [weak self] (model) in
                let detailController = DetailViewController.storyboardInit(detailModel: model)
                self?.navigationController?.pushViewController(detailController, animated: true)
            }).addDisposableTo(disposeBag)
    }
    
}







