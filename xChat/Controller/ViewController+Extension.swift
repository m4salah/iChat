//
//  ViewController+Extension.swift
//  xChat
//
//  Created by Mohamed Abdelkhalek Salah on 5/10/20.
//  Copyright © 2020 Mohamed Abdelkhalek Salah. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Continue!", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}
