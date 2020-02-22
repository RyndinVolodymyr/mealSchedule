//
//  RecipeViewController.swift
//  mealSchedule
//
//  Created by Владимир Рындин on 7/27/19.
//  Copyright © 2019 com.ryndinvi. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Firebase
import FirebaseStorage
import Kingfisher

class RecipeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var menuArray = [Menu]()
    
    var db: Firestore!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
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
                    self.collectionView.reloadData()
                    print("menu array \(self.menuArray)")
                }
            }
        }
    }
}

extension RecipeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: menuCell, for: indexPath) as? MenuCollectionViewCell {
            cell.menu = menuArray[indexPath.row]
            return cell
        }
    return UICollectionViewCell()
    }
}
