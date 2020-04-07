//
//  BMRViewController.swift
//  mealSchedule
//
//  Created by Владимир Рындин on 17.01.2020.
//  Copyright © 2020 com.ryndinvi. All rights reserved.
//

import UIKit

class BMRViewController: UIViewController {
    
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var heightLanel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var trainingLabel: UILabel!
    @IBOutlet weak var sexlabel: UILabel!
    
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    
    @IBOutlet weak var trainingSegment: UISegmentedControl!
    @IBOutlet weak var sexSegment: UISegmentedControl!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        let userDefaults = UserDefaults.standard
        readFromUserDefaults()
        userDefaults.synchronize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userDefaults = UserDefaults.standard
        readFromUserDefaults()
        userDefaults.synchronize()
        
        ageTextField.layer.cornerRadius = 10.0
        heightTextField.layer.cornerRadius = 10.0
        weightTextField.layer.cornerRadius = 10.0
        resultLabel.layer.cornerRadius = 10.0
    }
    
    @IBAction func calculate(_ sender: Any) {
        let userDefaults = UserDefaults.standard
        userDefaults.synchronize()
        writeToUserDefaults()
        
        var bmr: Double
        bmr = Double.init()
        var bmi: Double
        bmi = Double.init()
            
        if let age: Int = Int(ageTextField.text!) {
            if let height: Int = Int(heightTextField.text!)  {
                if let weight: Int = Int(weightTextField.text!) {
                    switch sexSegment.selectedSegmentIndex {
                    case 0:
                    bmr = 88.362 + 13.397 * Double(weight) + 4.799 * Double(height) - 5.677 * Double(age)
                    case 1:
                    bmr = 447.593 + 9.247 * Double(weight) + 3.098 * Double(height) - 4.330 * Double(age)
                    default: bmr = 0
                    }
                    bmi = Double(weight) / pow(Double(height)/100,2)
                }
            }
        }
            
        let factor = [1.375, 1.55, 1.725, 1.9]
        let selectedFactor = factor[trainingSegment.selectedSegmentIndex]
        bmr *= selectedFactor
        
        UIApplication.shared.keyWindow!.endEditing(true)
          
        switch(Float(bmi)) {
        case 0..<15:
            resultLabel.text = "Вы дожны употреблять \(Int(bmr)) килокалорий для поддержания веса.\nИндекс массы тела \(Int(bmi)).\nВыраженный дефицит массы тела"
        case 15..<18:
            resultLabel.text = "Вы дожны употреблять \(Int(bmr)) килокалорий для поддержания веса.\nИндекс массы тела \(Int(bmi)).\nНедостаточная дефицит масса тела"
        case 18..<25:
            resultLabel.text = "Вы дожны употреблять \(Int(bmr)) килокалорий для поддержания веса.\nИндекс массы тела \(Int(bmi)).\nНормальное телосложение"
        case 25..<30:
            resultLabel.text = "Вы дожны употреблять \(Int(bmr)) килокалорий для поддержания веса.\nИндекс массы тела \(Int(bmi)).\nИзбыточная масса тела(предожирение)"
        case 30..<35:
            resultLabel.text = "Вы дожны употреблять \(Int(bmr)) килокалорий для поддержания веса.\nИндекс массы тела \(Int(bmi)).\nОжирение первой степени"
        case 35..<40:
            resultLabel.text = "Вы дожны употреблять \(Int(bmr)) килокалорий для поддержания веса.\nИндекс массы тела \(Int(bmi)).\nОжирение второй степени"
        case 40...9999999:
            resultLabel.text = "Вы дожны употреблять \(Int(bmr)) килокалорий для поддержания веса.\nИндекс массы тела \(Int(bmi)).\nОжирение третьей степени"
        default: print("error")
        }
        userDefaults.set(Int(bmr), forKey: Token.bmrToken.rawValue)
        userDefaults.set(Int(bmi), forKey: Token.bmiToken.rawValue)
    }
//MARK: User Defaults Read Settings
    
    func readFromUserDefaults() {
        let userDefaults = UserDefaults.standard
        ageTextField.text = userDefaults.string(forKey: Token.ageTextField.rawValue)
        heightTextField.text = userDefaults.string(forKey: Token.heightTextField.rawValue)
        weightTextField.text = userDefaults.string(forKey: Token.weightTextField.rawValue)
        resultLabel.text = userDefaults.string(forKey: Token.resultLabel.rawValue)
        trainingSegment.selectedSegmentIndex = userDefaults.integer(forKey: Token.trainingSegment.rawValue)
        sexSegment.selectedSegmentIndex = userDefaults.integer(forKey: Token.sexSegment.rawValue)
        userDefaults.synchronize()
    }
    
    func writeToUserDefaults() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(ageTextField.text, forKey: Token.ageTextField.rawValue)
        userDefaults.set(heightTextField.text, forKey: Token.heightTextField.rawValue)
        userDefaults.set(weightTextField.text, forKey: Token.weightTextField.rawValue)
        userDefaults.set(resultLabel.text, forKey: Token.resultLabel.rawValue)
        userDefaults.set(trainingSegment.selectedSegmentIndex, forKey: Token.trainingSegment.rawValue)
        userDefaults.set(sexSegment.selectedSegmentIndex, forKey: Token.sexSegment.rawValue)
        userDefaults.synchronize()
    }
}
    
    

    



