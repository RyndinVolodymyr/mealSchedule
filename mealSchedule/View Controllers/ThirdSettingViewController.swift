//
//  TableViewController.swift
//  mealSchedule
//
//  Created by Владимир Рындин on 4/22/19.
//  Copyright © 2019 com.ryndinvi. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import FBSDKLoginKit

class ScheduleViewController: UIViewController {
    
    
    
    @IBOutlet weak var firstFoodTake: UIPickerView!
    @IBOutlet weak var secondFoodTake: UIPickerView!
    @IBOutlet weak var thirdFoodTake: UIPickerView!
    @IBOutlet weak var fourthFoodTake: UIPickerView!
    @IBOutlet weak var fiveFoodTake: UIPickerView!
    @IBOutlet weak var sixFoodTake: UIPickerView!
    @IBOutlet weak var sevenFoodTake: UIPickerView!
    

    override func viewDidLoad() {
        super.viewDidLoad()


    }

}
    
    let time = [["04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "00"], ["00", "05", "10", "15", "20", "25", "30", "35", "40", "45", "50", "55"]]
    
    //MARK: Picker View Extensions
    extension ScheduleViewController: UIPickerViewDelegate, UIPickerViewDataSource {
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 2
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return time[component].count
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return time[component][row]
        }
     
}
