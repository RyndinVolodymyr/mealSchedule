//
//  SnapShotExtensions.swift
//  mealSchedule
//
//  Created by Владимир Рындин on 7/29/19.
//  Copyright © 2019 com.ryndinvi. All rights reserved.
//

import Foundation
import FirebaseFirestore

extension QueryDocumentSnapshot {
    
    func decode<T: Decodable>() throws -> T {
        let jsonData = try JSONSerialization.data(withJSONObject: data(), options: [])
        let object = try JSONDecoder().decode(T.self, from: jsonData)
        return object
    }
}

extension QuerySnapshot {
    func decode<T: Decodable>() throws -> [T] {
        let objects: [T] = try documents.map({ try $0.decode() })
        return objects
    }
}
