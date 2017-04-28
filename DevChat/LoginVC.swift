//
//  LoginVC.swift
//  DevChat
//
//  Created by PRO on 4/28/17.
//  Copyright © 2017 Lazar. All rights reserved.
//

import UIKit

class LoginVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailField: CustomField!
    @IBOutlet weak var passwordField: CustomField!
    override func viewDidLoad() {
        super.viewDidLoad()

        emailField.delegate = self
        passwordField.delegate = self
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    @IBAction func loginPressed(_ sender: Any) {
        
        if let email = emailField.text, !email.isEmpty, let pwd = passwordField.text, !pwd.isEmpty {
            
            AuthServices.instance.login(email: email, password: pwd, onComplete: {(errMsg, data) in
                
                guard errMsg == nil else {
                    let alert = UIAlertController(title: "Error Authentication", message: errMsg, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    return
                }
                self.dismiss(animated: true, completion: nil)
                
            })
            
        } else {
            let alert = UIAlertController(title: "Missing", message: "You must enter both a username and a password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        
    }
}
