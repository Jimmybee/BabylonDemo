//
//  UIAlertController.swift
//  BabylonPosts
//
//  Created by James Birtwell on 12/07/2017.
//  Copyright © 2017 James Birtwell. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    static func defaultError() -> UIAlertController {
            let alertController = UIAlertController(title: "Error", message: "Unknown Error", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(action)
            return alertController
    }
}
