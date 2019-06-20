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
        firebaseGet()
        
        let token: [String: AnyObject] = [Messaging.messaging().fcmToken!: Messaging.messaging().fcmToken as AnyObject]
        
        self.postToken(tokenF: token)
    }
    
    //MARK: Firebase Messaging Token function
    
    func postToken(tokenF: [String: AnyObject]) {
        print("FCM Token \(tokenF)")
        
        let dbRef = Database.database().reference()
        dbRef.child("users/\(key ?? "AutoId")/fcmToken").child(Messaging.messaging().fcmToken!).setValue(tokenF)
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

