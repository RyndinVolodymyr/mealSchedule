//
//  JsonModel.swift
//  mealSchedule
//
//  Created by Владимир Рындин on 15.12.2019.
//  Copyright © 2019 com.ryndinvi. All rights reserved.
//

import Foundation

var fileJsontoPost = ["goal": Token.destinyChooseSegment.hashValue, "schedule": arrayDishes, "fcmToken": token, "timeZoneOffset": minutesFromUTC, "active": true ] as [String : Any]

func jsonPost() {

    let url = URL(string: "https://us-central1-mealschedule-58525.cloudfunctions.net/api")
    guard let requestUrl = url else { fatalError() }
    // Prepare URL Request Object
    var request = URLRequest(url: requestUrl)
    request.httpMethod = "POST"
     
    // HTTP Request Parameters which will be sent in HTTP Request Body
    let postString = "";
    // Set HTTP Request Body
    request.httpBody = postString.data(using: String.Encoding.utf8);
    // Perform HTTP Request
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Check for Error
            if let error = error {
                print("Error took place \(error)")
                return
            }
     
            // Convert HTTP Response Data to a String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
            }
    }
task.resume()
}
