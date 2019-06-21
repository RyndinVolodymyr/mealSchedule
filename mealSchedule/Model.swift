//
//  Model.swift
//  mealSchedule
//
//  Created by Владимир Рындин on 4/20/19.
//  Copyright © 2019 com.ryndinvi. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseStorage
import FirebaseMessaging
import FirebaseAuth

//MARK: Creating reference for Firebase

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

//MARK: cheking all properties

func chekStatus(array: [String: Any]) -> Bool {
    for (_, value) in array.enumerated() {
        switch value.key {
        case "foodCookSwitch": dicChek.updateValue(value.value, forKey: value.key)
            print("1. foodCook OK")
        case "trainingSwitch": dicChek.updateValue(value.value, forKey: value.key)
            print("2. training OK")
        case "quantFoodPicker": dicChek.updateValue(value.value, forKey: value.key)
            print("3. quant OK")
        case "weakUpPicker": dicChek.updateValue(value.value, forKey: value.key)
            print("4. weak Up OK")
        case "sleepPicker": dicChek.updateValue(value.value, forKey: value.key)
            print("5. sleep OK")
        case "destinyChooseSegment": dicChek.updateValue(value.value, forKey: value.key)
            print("6. destiny segment Ok")
        default: print("OH shiiit")
        }
    }
    for (index, value) in dicChek.enumerated() {
        print(index, value)
    }
    
    //MARK: Check count settings
    
    if dicChek.count == 6 {
        return true
    } else {
        return false
    }
}

//MARK: NSDate

let date = NSDate()

//MARK: retrive data from firebase

func firebaseGet() {
    let fRef = Database.database().reference(withPath: "users")
    
    fRef.observe(.value, with: { snapshot in
        
        print("FIREBASE RETRIVE \(snapshot.value as Any)")
    })
}

//MARK: Calculation parametrs


