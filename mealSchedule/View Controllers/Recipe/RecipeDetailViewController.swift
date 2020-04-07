//
//  RecipeDetailViewController.swift
//  mealSchedule
//
//  Created by Владимир Рындин on 7/27/19.
//  Copyright © 2019 com.ryndinvi. All rights reserved.
//

import UIKit
import Kingfisher

class RecipeDetailViewController: UIViewController {

    @IBOutlet weak var nameLabelDetail: UILabel!
    
    @IBOutlet weak var imageDetail: UIImageView! {
        didSet {
            imageDetail.layer.borderWidth = 3
            imageDetail.layer.masksToBounds = false
            imageDetail.clipsToBounds = true
            imageDetail.layer.borderColor = UIColor.black.cgColor
            imageDetail.layer.cornerRadius = imageDetail.frame.height / 2
         }
    }
    @IBOutlet weak var textDetail: UITextView!

    var menu: Menu?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var menu: Menu? {
               didSet {
                   nameLabelDetail.text = menu?.name
                   textDetail.text = menu?.cook
                   imageDetail.kf.indicatorType = .activity
                   imageDetail.kf.setImage(with: URL(string: menu?.imageURL ?? "https://firebasestorage.googleapis.com/v0/b/mealschedule-58525.appspot.com/o/RecipesImages%2Fpizza.jpg?alt=media&token=3f0d2622-5157-4906-b9dc-331b07d9052f"))
               }
           }
    }
    
}
