//
//  JsonModel.swift
//  mealSchedule
//
//  Created by Владимир Рындин on 15.12.2019.
//  Copyright © 2019 com.ryndinvi. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage
import FirebaseMessaging
import FirebaseAuth

func jsonPost() {
    
    //MARK: GEt firebase ID TOken for authorization
    
    let currentUser = Auth.auth().currentUser
    currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
        if let error = error {
            print(error.localizedDescription)
            return
        }
        print("idTOKen \(idToken!)")
 
        // prepare json data
        var postGoal: String?
        let goal = userDefaults.integer(forKey: Token.destinyChooseSegment.rawValue)
        switch goal {
            case 0: postGoal = "weightLoss"
            case 1: postGoal = "norm"
            case 2: postGoal = "weightGain"
            default: print("Default")
        }
        let json: [String: Any] = ["goal": postGoal!, "schedule": arrayDishes, "fcmToken": token, "timeZoneOffset": minutesFromUTC, "active": true ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)

    // create post request
        let url = URL(string: "https://us-central1-mealschedule-58525.cloudfunctions.net/api/settings/")!
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
      
        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue( "Bearer \(idToken!)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
            print(error?.localizedDescription ?? "No data")
            return
        }
            //response Json 
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print("response Json \(responseJSON)")
            }
        }
        task.resume()
    }
}
