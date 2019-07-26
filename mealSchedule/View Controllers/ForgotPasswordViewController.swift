//
//  ForgotPasswordViewController.swift
//  mealSchedule
//
//  Created by Владимир Рындин on 4/26/19.
//  Copyright © 2019 com.ryndinvi. All rights reserved.
//

import UIKit
import Firebase

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var emaillabel: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func forgotPasswordAction(_ sender: UIButton) {
        let email = emaillabel.text!
        if(!email.isEmpty) {
            Auth.auth().sendPasswordReset(withEmail: email) { (error) in
                if error == nil {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func closeAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
