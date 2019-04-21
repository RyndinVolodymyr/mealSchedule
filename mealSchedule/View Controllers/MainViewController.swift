//
//  MainViewController.swift
//  mealSchedule
//
//  Created by Владимир Рындин on 4/21/19.
//  Copyright © 2019 com.ryndinvi. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    
    @IBOutlet weak var settingsButton: UIButton!
    
    @IBOutlet weak var muteButton: UIButton!
    
    @IBOutlet weak var mealButton: UIButton!
    
    @IBOutlet weak var sportSettingsButton: UIButton!
    
    @IBOutlet weak var infoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if chekStatus(array: userDefaults.dictionaryRepresentation()) {
             infoLabel.text = "Setting Status" + " Saved"
        } else {
            infoLabel.text = "Settings Status" + " NOT Saved"
        }
        
    }

}
