//
//  AuthorViewController.swift
//  mealSchedule
//
//  Created by Владимир Рындин on 4/23/19.
//  Copyright © 2019 com.ryndinvi. All rights reserved.
//

import UIKit
import Firebase

class AuthorViewController: UIViewController {

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
    
    @IBOutlet weak var enterButtonWeak: UIButton!
    @IBOutlet weak var registranionLabel: UILabel!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var emaillabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    @IBOutlet weak var accountlabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.delegate = self
        emaillabel.delegate = self
        passwordLabel.delegate = self
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
                            print(result.user.uid)
                            let ref = Database.database().reference().child("users")
                            ref.child(result.user.uid).updateChildValues(["name": name, "email": email])
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
