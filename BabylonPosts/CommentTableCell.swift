//
//  CommentTableCell.swift
//  BabylonPosts
//
//  Created by James Birtwell on 12/07/2017.
//  Copyright © 2017 James Birtwell. All rights reserved.
//

import UIKit

class CommentTableCell: UITableViewCell {
    
    @IBOutlet weak var commentLabel: UILabel!
  
    var comment: Comment!
    
    func setupCellState(comment: Comment){
       self.comment = comment
        commentLabel.text = comment.body
    }
    
}
