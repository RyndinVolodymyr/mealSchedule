//
//  WelcomeViewController.swift
//  mealSchedule
//
//  Created by Владимир Рындин on 4/23/19.
//  Copyright © 2019 com.ryndinvi. All rights reserved.
//

import UIKit
import Firebase

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func logoutAction(_ sender: Any) {
        do{
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
       
    }
    

}
