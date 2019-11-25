//
//  ViewController.swift
//  mealSchedule
//
//  Created by Владимир Рындин on 4/9/19.
//  Copyright © 2019 com.ryndinvi. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import FBSDKLoginKit

class FirstSettingsViewController: UIViewController {
    
    @IBOutlet weak var destinyLabel: UILabel!
    @IBOutlet weak var coockingChooseLabel: UILabel!
    @IBOutlet weak var trainingLabel: UILabel!
    @IBOutlet weak var quantFoodLabel: UILabel!
    @IBOutlet weak var weakUpLabel: UILabel!
    @IBOutlet weak var sleepLabel: UILabel!
    @IBOutlet weak var foodCookSwitch: UISwitch!
    @IBOutlet weak var trainingSwitch: UISwitch!
    @IBOutlet weak var coockingButtonHide: UIButton!
    @IBOutlet weak var trainingButtonHide: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var quantFoodPicker: UIPickerView!
    @IBOutlet weak var weakUpPicker: UIPickerView!
    @IBOutlet weak var sleepPicker: UIPickerView!
    @IBOutlet weak var destinyChooseSegment: UISegmentedControl!
    
    override func viewWillAppear(_ animated: Bool) {
        
        let userDefaults = UserDefaults.standard
        readFromUserDefaults()
        userDefaults.synchronize()
        showHiddenButtons(but: coockingButtonHide, swt: foodCookSwitch)
        showHiddenButtons(but: trainingButtonHide, swt: trainingSwitch)
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quantFoodPicker.dataSource = self
        quantFoodPicker.delegate = self
        weakUpPicker.dataSource = self
        sleepPicker.dataSource = self
        weakUpPicker.delegate = self
        sleepPicker.delegate = self
        
        let userDefaults = UserDefaults.standard
        readFromUserDefaults()
        userDefaults.synchronize()
        
        print("MINUTES BETween \(minutesFromUTC)")
        
        self.foodCookSwitch.addTarget(self, action:#selector(switchShowButtonFood(param:)), for: .valueChanged)
        self.trainingSwitch.addTarget(self, action: #selector(switchShowButtonTrain(param:)), for: .valueChanged)
    }
    //MARK: OBJC Func creating
    
    @objc func switchShowButtonTrain(param: UISwitch) {
        showHiddenButtons(but: trainingButtonHide, swt: param)
    }
    
    @objc func switchShowButtonFood(param: UISwitch) {
        showHiddenButtons(but: coockingButtonHide, swt: param)
    }
    
    @IBAction func destinySegControl(_ sender: Any) {
    }
    
    @IBAction func saveButton(_ sender: Any) {
        let userDefaults = UserDefaults.standard
        userDefaults.synchronize()
        writeToUserDefaults()
        shedule()
        pikerSettings()
        
        // MARK: Sending data to firebase
        
        let dataUP = ["id": key ?? "AutoId", "foodCookSwitch": foodCookSwitch.isOn, "trainingSwitch": trainingSwitch.isOn, "destinyChooseSegment": destinyChooseSegment.selectedSegmentIndex, "quantFoodPicker": quantFoodPicker.selectedRow(inComponent: 0), "weakUpPicker": weakUpPicker.selectedRow(inComponent: 0), "sleepPicker": sleepPicker.selectedRow(inComponent: 0), "FCMToken": token] as [String : Any]
        ref.child("users").child(key!).updateChildValues(dataUP)
    }
}


//MARK: Picker View Extensions
extension FirstSettingsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {

        switch pickerView {
        case quantFoodPicker: return 1
        default: return 2
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case quantFoodPicker: return arrayEating.count
        case weakUpPicker: return arrayWeakUp[component].count
        case sleepPicker: return arraySleep[component].count
        default: return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case quantFoodPicker: return arrayEating[row]
        case weakUpPicker: return arrayWeakUp[component][row]
        case sleepPicker: return arraySleep[component][row]
        default: return "Shiieeeet"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            switch pickerView {
            case quantFoodPicker: userDefaults.set(row, forKey: Token.quantFoodPicker.rawValue)
            case weakUpPicker: userDefaults.set(row, forKey: Token.weakUpPicker.rawValue)
            case sleepPicker: userDefaults.set(row, forKey: Token.sleepPicker.rawValue)
            default: print("Did Select error")
            }
        case 1:
            switch pickerView {
            case weakUpPicker: userDefaults.set(row, forKey: Token.weakUpPickerMinutes.rawValue)
            case sleepPicker: userDefaults.set(row, forKey: Token.sleepPickerMinutes.rawValue)
            default: print("Did Select error")
            }
        default: print("DIdSelect Component")
        }
    }
    
    //MARK: Picker View settings
    func pikerSettings() {
        if let quantFoodPick = userDefaults.object(forKey: Token.quantFoodPicker.rawValue) as? Int {
            quantFoodPicker.selectRow(quantFoodPick, inComponent: 0, animated: true)
        }
        if let weakUpPick = userDefaults.object(forKey: Token.weakUpPicker.rawValue) as? Int {
            weakUpPicker.selectRow(weakUpPick, inComponent: 0, animated: true)
        }
        if let sleepPick = userDefaults.object(forKey: Token.sleepPicker.rawValue) as? Int {
            sleepPicker.selectRow(sleepPick, inComponent: 0, animated: true)
        }
    }

    //MARK: User Defaults Read Settings
    func readFromUserDefaults() {
        let userDefaults = UserDefaults.standard
        foodCookSwitch.isOn = userDefaults.bool(forKey: Token.foodCookSwitch.rawValue)
        trainingSwitch.isOn = userDefaults.bool(forKey: Token.trainingSwitch.rawValue)
        destinyChooseSegment.selectedSegmentIndex = userDefaults.integer(forKey: Token.destinyChooseSegment.rawValue)
        quantFoodPicker.selectRow(userDefaults.integer(forKey: Token.quantFoodPicker.rawValue), inComponent: 0, animated: true)
        weakUpPicker.selectRow(userDefaults.integer(forKey: Token.weakUpPicker.rawValue), inComponent: 0, animated: true)
        weakUpPicker.selectRow(userDefaults.integer(forKey: Token.weakUpPickerMinutes.rawValue), inComponent: 1, animated: true)
        sleepPicker.selectRow(userDefaults.integer(forKey: Token.sleepPickerMinutes.rawValue), inComponent: 1, animated: true)
        sleepPicker.selectRow(userDefaults.integer(forKey: Token.sleepPicker.rawValue), inComponent: 0, animated: true)
        
        userDefaults.synchronize()
    }
    //MARK: User Defaults Write Settings
    func writeToUserDefaults() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(foodCookSwitch.isOn, forKey: Token.foodCookSwitch.rawValue)
        userDefaults.set(trainingSwitch.isOn, forKey: Token.trainingSwitch.rawValue)
        userDefaults.set(destinyChooseSegment.selectedSegmentIndex, forKey: Token.destinyChooseSegment.rawValue)
        print("Saved to user def")
        userDefaults.synchronize()
    }
}
