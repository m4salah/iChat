//
//  LoginViewController.swift
//  xChat
//
//  Created by Mohamed Abdelkhalek Salah on 5/9/20.
//  Copyright © 2020 Mohamed Abdelkhalek Salah. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var activityInicator: UIActivityIndicatorView!
    @IBOutlet var loginButton: UIButton!
    
    var handleUser: AuthStateDidChangeListenerHandle!
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func loging(_ state: Bool) {
        state ? activityInicator.startAnimating() : activityInicator.stopAnimating()
        
        usernameTextField.isEnabled = !state
        passwordTextField.isEnabled = !state
        loginButton.isEnabled = !state
        
    }
    @IBAction func loginPressed(_ sender: Any) {
        loging(true)
        Auth.auth().signIn(withEmail: usernameTextField.text ?? "", password: passwordTextField.text ?? "") { authResult, error in
            if let error = error {
                self.loging(false)
                self.showAlert(title: "Error!", message: error.localizedDescription)
            }
            if let _ = authResult {
                self.loging(false)
                self.performSegue(withIdentifier: Constants.loginSegue, sender: nil)
            }
        }
    }
}
