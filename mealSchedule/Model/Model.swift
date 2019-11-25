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



//MARK: Deference between UTC and user Time Zone in minutes
var minutesFromUTC: Int { return TimeZone.current.secondsFromGMT() / 60 }

//MARK: func shedule

func shedule() {
    guard let count = userDefaults.object(forKey: Token.quantFoodPicker.rawValue) as? Int
    else { return }
    
    guard  let sleeping = userDefaults.object(forKey: Token.sleepPicker.rawValue) as? Int
    else { return }
    
    guard let morning = userDefaults.object(forKey: Token.weakUpPicker.rawValue) as? Int
    else { return }
//
//    guard let sleepMinute = userDefaults.object(forKey: Token.sleepPickerMinutes.rawValue) as? Int
//    else { return }
//
//    guard let morningMinutes = userDefaults.object(forKey: Token.weakUpPickerMinutes.rawValue) as? Int
//    else { return }
                        
    let sleepingNormalized = sleeping + 18
    let sleepingFullMins = (sleepingNormalized > 23 ? 23 : sleepingNormalized) * 60
    let morningFullMins = ((morning + 4) * 60)
    
    let step = (sleepingFullMins - morningFullMins)/count
                
    var arrayDishes = [Int]()
    for i in 0...count {
            arrayDishes.append(morningFullMins + step * i)
    }
    print("array of dishes \(arrayDishes)")
    
}


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

let arrayEating = ["1", "2", "3", "4", "5", "6", "7"]
let arrayWeakUp = [["04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14"], ["00", "05", "10", "15", "20", "25", "30", "35", "40", "45", "50", "55"]]
let arraySleep = [["18", "19", "20", "21", "22", "23", "00", "01", "02", "03"], ["00", "05", "10", "15", "20", "25", "30", "35", "40", "45", "50", "55"]]

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
    case weakUpPickerMinutes
    case sleepPickerMinutes
}

//MARK: NSDate

let date = NSDate()


//MARK: identifiers of seguae

let menuCell = "MenuCell"

//MARK: Model of Recipes

protocol DocumentSerializable {
    init?(dictionary:[String: Any])
}

struct Menu: Decodable {
    var imageURL: String?
    var name: String?
    var cook: String
    var cal: String?
}

extension Menu: DocumentSerializable {
    init?(dictionary: [String : Any]) {
        guard let name = dictionary["name"] as? String,
            let cook = dictionary["cook"] as? String,
            let imageURL = dictionary["imageURL"] as? String,
            let cal = dictionary["cal"] as? String else { return nil }
        self.init(imageURL: imageURL, name: name, cook: cook, cal: cal)
    }
}
