//
//  RegistrationViewController.swift
//  xChat
//
//  Created by Mohamed Abdelkhalek Salah on 5/9/20.
//  Copyright © 2020 Mohamed Abdelkhalek Salah. All rights reserved.
//

import UIKit
import Firebase

class RegistrationViewController: UIViewController {

    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var activityIdicator: UIActivityIndicatorView!
    @IBOutlet var registerButton: UIButton!
    
    func loging(_ state: Bool) {
        state ? activityIdicator.startAnimating() : activityIdicator.stopAnimating()
        
        usernameTextField.isEnabled = !state
        passwordTextField.isEnabled = !state
        registerButton.isEnabled = !state
        
    }
    
    @IBAction func registerPressed(_ sender: Any) {
        loging(true)
        Auth.auth().createUser(withEmail: usernameTextField.text ?? "", password: passwordTextField.text ?? "") { authResult, error in
            if let _ = authResult  {
                self.loging(false)
                self.performSegue(withIdentifier: Constants.registrationSegue, sender: nil)
            }
            if let error = error {
                self.loging(false)
                self.showAlert(title: "Error!", message: error.localizedDescription)
            }
        }
    }
}
