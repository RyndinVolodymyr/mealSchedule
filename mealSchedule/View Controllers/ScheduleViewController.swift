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
import Kingfisher
import FirebaseStorage
import FirebaseFirestore

class ScheduleViewController: UIViewController {

    var menuArray = [Menu]()
    var db: Firestore!
    
    let dishes: [String] = ["Завтрак", "Обед", "Перкус", "Полдник", "Перкус", "Ужин"]

    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()

        tableView.delegate = self
        tableView.dataSource = self
        
        loadData()
    
    }
    func loadData() {
        db.collection("recipes").getDocuments() {
            querySnapshot, error in
            if let error = error {
                print("Error loading data filed \(error.localizedDescription)")
            } else {
                self.menuArray = try! querySnapshot!.decode()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    print("menu array \(self.menuArray)")
                }
            }
        }
    }
}

extension ScheduleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? MenuTableViewCell {
            
            cell.menu = menuArray[indexPath.row]
            return cell
        }
        return MenuTableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        
        
    }
}
