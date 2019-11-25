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
    
    //MARK: Creating FB standart button
    let facebookButton: FBLoginButton = {
        let buttonFb = FBLoginButton()
        buttonFb.translatesAutoresizingMaskIntoConstraints = false
        buttonFb.permissions  = ["email", "public_profile"]
        return buttonFb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.delegate = self
        emaillabel.delegate = self
        passwordLabel.delegate = self
        facebookButton.delegate = self
        
        view.addSubview(facebookButton)
        setupLayout()
    }
    
    @IBAction func enterButton(_ sender: UIButton) {
        singUP = !singUP
    }
    
    func showAllert() {
        let alert = UIAlertController(title: "Ошибка", message: "Заполните все поля", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func setupLayout() {
        facebookButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        facebookButton.bottomAnchor.constraint(equalTo: enterButtonWeak.bottomAnchor, constant: 50).isActive = true
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
//MARK: Facebook author button extensions

extension AuthorViewController: LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if result!.isCancelled {
            print("Is Cancelled")
        } else {
            if error == nil {
                GraphRequest(graphPath: "me", parameters: ["friends": "email, name"], tokenString: AccessToken.current?.tokenString, version: nil, httpMethod: HTTPMethod(rawValue: "GET")).start(completionHandler: { (nil, result, error) in
                    if error == nil {
                        print("Facebook result: \(result ?? "Facebook error")")
                        let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
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

    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("LogOUT")
    }
}
