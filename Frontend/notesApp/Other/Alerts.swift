//
//  errors.swift
//  notesApp
//
//  Created by Arkash Vijayakumar on 10/01/2022.
//

import Foundation
import UIKit


class AlertErrors: UIViewController {
    
    static func dismissError(vc: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss",
                                      style: .cancel,
                                      handler: nil))
    
        vc.present(alert, animated: true, completion: nil)
    }
    
    
  
    
}
