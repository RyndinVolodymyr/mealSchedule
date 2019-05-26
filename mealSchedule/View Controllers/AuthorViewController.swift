//
//  AuthorViewController.swift
//  mealSchedule
//
//  Created by Владимир Рындин on 4/23/19.
//  Copyright © 2019 com.ryndinvi. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit

class AuthorViewController: UIViewController {

    @IBOutlet weak var enterButtonWeak: UIButton!
    @IBOutlet weak var registranionLabel: UILabel!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var emaillabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    @IBOutlet weak var accountlabel: UILabel!
    
    var singUP: Bool = true {
        willSet {
            if newValue {
                registranionLabel.text = "Регистрация"
                nameLabel.isHidden = false
                enterButtonWeak.setTitle("Войти", for: .normal)
            } else {
                registranionLabel.text = "Вход"
                nameLabel.isHidden = true
                enterButtonWeak.setTitle("Регистрация", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.delegate = self
        emaillabel.delegate = self
        passwordLabel.delegate = self
        
        //MARK: Creating FB standart button
        
        let buttonFB = FBSDKLoginButton()
        buttonFB.frame.origin.x = 70
        buttonFB.frame.origin.y = 450
        
        buttonFB.delegate = self
        buttonFB.readPermissions = ["email", "public_profile"]
        self.view.addSubview(buttonFB)
    }
    
    @IBAction func enterButton(_ sender: UIButton) {
        singUP = !singUP
    }
    
    func showAllert() {
        let alert = UIAlertController(title: "Ошибка", message: "Заполните все поля", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

//MARK: extensions

extension AuthorViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let name = nameLabel.text!
        let email = emaillabel.text!
        let password = passwordLabel.text!
        
        if(singUP) {
            if (!name.isEmpty && !email.isEmpty && !password.isEmpty) {
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    if error == nil {
                        if let result = result {
                            print("Registration compleated. User unic id - " + result.user.uid)
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                }
            } else {
                showAllert()
            }
        } else {
            if (!email.isEmpty && !password.isEmpty) {
                Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                    if error == nil {
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            } else {
                showAllert()
            }
        }
        return true
    }
}
//MARK: Facebook author button

extension AuthorViewController: FBSDKLoginButtonDelegate {
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if result.isCancelled {
            print("Is Cancelled")
        } else {
            if error == nil {
                FBSDKGraphRequest(graphPath: "me", parameters: ["friends": "email, name"], tokenString: FBSDKAccessToken.current()?.tokenString, version: nil, httpMethod: "GET")?.start(completionHandler: { (nil, result, error) in
                    if error == nil {
                        print("Facebook result: \(result ?? "Facebook error")")
                        let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                        Auth.auth().signInAndRetrieveData(with: credential, completion: { (result, error) in
                            if error == nil {
                                print(result?.user.uid ?? "Facebook error to get user id")
                                self.dismiss(animated: true, completion: nil)
                            } else {
                                print(error as Any)
                            }
                        })
                    }
                })
            }
        }
    }

    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("LogOUT")
    }
}
