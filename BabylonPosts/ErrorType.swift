//
//  ErrorType.swift
//  BabylonPosts
//
//  Created by James Birtwell on 12/07/2017.
//  Copyright © 2017 James Birtwell. All rights reserved.
//

import UIKit

enum ErrorType {
    case mapping
    case network
    
    var alert: UIAlertController {
        let alertController = UIAlertController(title: "Error", message: self.errorMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(action)
        return alertController
    }
    
    private var errorMessage: String  {
        switch self {
        case .mapping:
            return "There was an internal error"
        case .network:
            return "Please check your network status and try again."
        }
    }
}

