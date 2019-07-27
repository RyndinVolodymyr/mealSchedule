//
//  MainViewController.swift
//  mealSchedule
//
//  Created by Владимир Рындин on 4/21/19.
//  Copyright © 2019 com.ryndinvi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseMessaging

class MainViewController: UIViewController {
    
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var muteButton: UIButton!
    @IBOutlet weak var mealButton: UIButton!
    @IBOutlet weak var sportSettingsButton: UIButton!
    @IBOutlet weak var infoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showInfoLabelText()
    }
    
    @IBAction func logOutAction(_ sender: Any) {
        do{
            try Auth.auth().signOut()
        } catch {
            print("Error in log out action \(error)")
        }
    }
    
    @IBAction func FirstSettViewContrShow(_ sender: UIButton) {

    }
    
    func showInfoLabelText() {
        if nameInfo == nil || nameInfo!.isEmpty {
            infoLabel.text = "Hello Friend, Welcome to Meal Shhedule! Your settings status is "
        } else {
            infoLabel.text = "Hello \(nameInfo ?? "Unknown Name"), Welcome to Meal Shhedule! Your settings status is "
        }
    }
}

/*
 
 
 fweferbfe]wergsrt
 hrd
  e\rh
 erth
 etrh
 et
 hety
 h
 etyh
 etyh
 ety
 hety
 hety
 hety
 htye
 h
 tyeh
 teyh
 yt
 
 */

//MARK: Status bar item color

func uicolorFromHex(rgbValue:UInt32)->UIColor{
    let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
    let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
    let blue = CGFloat(rgbValue & 0xFF)/256.0
    
    return UIColor(red:red, green:green, blue:blue, alpha:1.0)
}
