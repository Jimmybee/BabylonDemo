//
//  DetailViewController.swift
//  BabylonPosts
//
//  Created by James Birtwell on 12/07/2017.
//  Copyright © 2017 James Birtwell. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DetailViewController: UIViewController {
    
    private static var storyboardId = "DetailViewController"
    
    static func storyboardInit(detailModel: DetailModel) -> DetailViewController {
        let vc = UIStoryboard.mainViewControllerWith(id: storyboardId) as! DetailViewController
        vc.detailModel = detailModel
        return vc
    }

    var detailModel: DetailModel!
    
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var detailTable: UITableView!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var commentCount: UILabel!
    @IBOutlet weak var postTitle: UILabel!

    @IBOutlet weak var postBody: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        author.text = detailModel?.author
        commentCount.text = "\(detailModel?.comments.count ?? 0)"
        postTitle.text = detailModel?.post.title
        postBody.text = detailModel?.post.body
        
        detailTable.rowHeight = UITableViewAutomaticDimension
        detailTable.estimatedRowHeight = 20
        
        just(detailModel.comments)
            .bindTo(detailTable
            .rx
            .items(cellIdentifier: "Cell",
                   cellType: CommentTableCell.self)) {
                    row, comment, cell in
                    cell.setupCellState(comment: comment)
            }
            .addDisposableTo(disposeBag)
        
    }
    
    
}


struct DetailModel {
    
    var post: Post
    var comments: [Comment]
    var author: String
    
    init(post: Post, author: String, comments: [Comment]) {
        self.post = post
        self.author = author
        self.comments = comments
    }
    
}
