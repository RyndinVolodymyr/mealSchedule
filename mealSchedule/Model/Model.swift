//
//  Model.swift
//  mealSchedule
//
//  Created by Владимир Рындин on 4/20/19.
//  Copyright © 2019 com.ryndinvi. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage
import FirebaseMessaging
import FirebaseAuth

//MARK: Recipe arrays

//let recipeNameArray = ["Похудение", "Норма", "Набор массы"]
//let recipeImageArray = [UIImage(named: "dieta"), UIImage(named: "norma"), UIImage(named: "nabor")]

//MARK: Creating reference for Firebase
let recipeCellIdentif = "recipeCellIdentif"
let token: [String: AnyObject] = [Messaging.messaging().fcmToken!: Messaging.messaging().fcmToken as AnyObject]
let nameInfo = Auth.auth().currentUser?.displayName
let key = Auth.auth().currentUser?.uid
let ref = Database.database().reference()

//MARK: Showing hiddien setings

func showHiddenButtons(but: UIButton, swt: UISwitch) {
    if swt.isOn {
        but.isHidden = false
        print("Button is hidden FALSE")
    } else {
        but.isHidden = true
        print("Button is hidden TRUE")
    }
}

//MARK: Creating arrays

let arrayEating = ["2", "3", "4", "5", "6", "7"]
let arrayWeakUp = ["06", "07", "08", "09", "10", "11", "12"]
let arraySleep = ["20", "21", "22", "23", "24", "01", "02", "03"]

var dicChek = [String : Any]()

//MARK: UserDefaults token settings

let userDefaults = UserDefaults.standard

enum Token: String {
    case foodCookSwitch
    case trainingSwitch
    case coockingButtonHide
    case trainingButtonHide
    case quantFoodPicker
    case weakUpPicker
    case sleepPicker
    case destinyChooseSegment
}

//MARK: NSDate

let date = NSDate()

//MARK: retrive data from firebase


//MARK: Calculation parametrs


