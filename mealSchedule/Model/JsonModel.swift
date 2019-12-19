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

//
//func jsonGet() {
//    let currentUser = Auth.auth().currentUser
//    currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
//        if let error = error {
//            print(error.localizedDescription)
//            return
//        }
//        print("idTOKen \(idToken!)")
//}
////MARK: Making json post string
//
//let postJson = ["goal": userDefaults.integer(forKey: Token.destinyChooseSegment.rawValue), "schedule": arrayDishes, "fcmToken": token, "timeZoneOffset": minutesFromUTC, "active": true, "count": arrayDishes.capacity] as [String : Any]
//}


func jsonPost() {
    
    let currentUser = Auth.auth().currentUser
        currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print("idTOKen \(idToken!)")
    }

    let dic = ["goal": userDefaults.integer(forKey: Token.destinyChooseSegment.rawValue), "schedule": [arrayDishes], "fcmToken": token, "timeZoneOffset": minutesFromUTC, "active": true ] as [String : Any]
    
//    let dic2 = ["goal" : "weightLoss", "schedule" : [720, 940, 1160], "fcmToken" : "fPU4fhxvPLc:APA91bEN-6MKYK_DeHuKBJW1-u4MaxartVXI6ebSHp38Z86eauAa-rQVOdcVqU6Z4fODeVbd-OKj7SLvQtRHQIhp4Z3XpaBoDmXz5qJLCc4XTIa6UArGROfR1VeJqT7TqYGGFgc_FIPI", "timeZoneOffset" : 120, "active": true] as [String : Any]

    var jsonData:Data?
    do {
        jsonData = try JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
    } catch {
        print(error.localizedDescription)
    }

    let url = URL(string: "https://us-central1-mealschedule-58525.cloudfunctions.net/api/settings")!
    var request = URLRequest(url: url)

    request.addValue("Baerer \(String(describing: currentUser))", forHTTPHeaderField: "Authorization")
    request.httpMethod = "POST"
    request.httpBody = jsonData


    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data, error == nil else {
            // check for fundamental networking error
            print("fundamental networking error=\(String(describing: error))")
            return
        }

        if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
            // check for http errors
            print("statusCode should be 200, but is \(httpStatus.statusCode)")
            print("response = \(String(describing: response))")
        }

        let responseString = String(data: data, encoding: .utf8)
        print("responseString = \(String(describing: responseString))")
    }
    task.resume()
}

//func jsonPost() {
//    struct ToDoResponseModel: Codable {
//        var userId: Int
//        var id: Int?
//        var title: String
//        var completed: Bool
//    }
//    let url = URL(string: "https://us-central1-mealschedule-58525.cloudfunctions.net/api/settings")
//    guard let requestUrl = url else { fatalError() }
//
//    var request = URLRequest(url: requestUrl)
//    request.httpMethod = "POST"
//
//    // Set HTTP Request Header
//    request.setValue("application/json", forHTTPHeaderField: "Accept")
//
//
//    let newTodoItem = ToDoResponseModel(userId: 300, title: "Urgent task 2", completed: true)
//    let jsonData = try JSONEncoder().encode(newTodoItem)
//
//
//
//    request.httpBody = jsonData
//
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//
//            if let error = error {
//                print("Error took place \(error)")
//                return
//            }
//            guard let data = data else {return}
//
//            do{
//                let todoItemModel = try JSONDecoder().decode(ToDoResponseModel.self, from: data)
//                print("Response data:\n \(todoItemModel)")
//                print("todoItemModel Title: \(todoItemModel.title)")
//                print("todoItemModel id: \(todoItemModel.id ?? 0)")
//            }catch let jsonErr{
//                print(jsonErr)
//           }
//    }
//    task.resume()
//}
//
//
//
//
//



//
//func jsonPost() {
//
//    //MARK: Get firebase id token
//
//    let currentUser = Auth.auth().currentUser
//    currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
//      if let error = error {
//        print(error.localizedDescription)
//        return;
//      }
//        print("idTOKen \(idToken!)")
//    }
//    //MARK: Making json post string
//
//    let postJson = ["goal": userDefaults.integer(forKey: Token.destinyChooseSegment.rawValue), "schedule": arrayDishes, "fcmToken": token, "timeZoneOffset": minutesFromUTC, "active": true, "count": arrayDishes.capacity] as [String : Any]
//
//    //MARK: HTTP Request Parameters which will be sent in HTTP Request Body
//    let jsonData = try JSONSerialization.data(withJSONObject: postJson, options: .prettyPrinted)
//
//    let postString = ""
//
//    let url = URL(string: "https://us-central1-mealschedule-58525.cloudfunctions.net/api/settings")
//    guard let requestUrl = url else { fatalError() }
//
//    // Prepare URL Request Object
//    var request = URLRequest(url: requestUrl)
//    request.httpMethod = "POST"
//    request.addValue("Baerer \(String(describing: currentUser))", forHTTPHeaderField: "Authorization")
//
//    // Set HTTP Request Body
//    request.httpBody = postString.data(using: String.Encoding.utf8);
//    // Perform HTTP Request
//    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            // Check for Error
//        if let error = error {
//            print("Error took place \(error)")
//            return
//        }
//
//        // Convert HTTP Response Data to a String
//        if let data = data, let dataString = String(data: data, encoding: .utf8) {
//            print("Response data string:\n \(dataString)")
//        }
//    }
//    task.resume()
////}
//func jsonPost() -> URLSessionDataTask {
//        //MARK: Get firebase id token
//        let currentUser = Auth.auth().currentUser
//        currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
//          if let error = error {
//            print(error.localizedDescription)
//            return;
//          }
//            print("idTOKen \(idToken!)")
//        }
//        //MARK: Making json post string
//        let postJson = ["goal": userDefaults.integer(forKey: Token.destinyChooseSegment.rawValue), "schedule": arrayDishes, "fcmToken": token, "timeZoneOffset": minutesFromUTC, "active": true, "count": arrayDishes.capacity] as [String : Any]
//    do {
//        //MARK: HTTP Request Parameters which will be sent in HTTP Request Body
//        let jsonData = try JSONSerialization.data(withJSONObject: postJson, options: .prettyPrinted)
//    // create post request
//    let url = NSURL(string: "https://us-central1-mealschedule-58525.cloudfunctions.net/api/settings")
//        let request = NSMutableURLRequest(url: url! as URL)
//        request.httpMethod = "POST"
//    // insert json data to the request
//        request.addValue("Baerer \(String(describing: currentUser))", forHTTPHeaderField: "Authorization")
//        request.httpBody = jsonData
//        let task = URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
//        if error != nil{
//            print("Error -> \(String(describing: error))")
//            return
//        }
//        do {
//            let result = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:AnyObject]
//            print("Result -> \(String(describing: result))")
//        } catch {
//            print("Error -> \(error)")
//        }
//    }
//        task.resume()
//        return task
//} catch {
//    print(error)
//}
//    return task
//}
