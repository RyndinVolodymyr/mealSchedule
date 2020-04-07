//
//  MenuTableViewCell.swift
//  mealSchedule
//
//  Created by Владимир Рындин on 24.03.2020.
//  Copyright © 2020 com.ryndinvi. All rights reserved.
//

import UIKit
import Kingfisher

class MenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageMenuCell : UIImageView! {
        didSet {
            imageMenuCell.layer.borderWidth = 3
            imageMenuCell.layer.masksToBounds = false
            imageMenuCell.clipsToBounds = true
            imageMenuCell.layer.borderColor = UIColor.black.cgColor
            imageMenuCell.layer.cornerRadius = imageMenuCell.frame.height / 2
        }
    }
    @IBOutlet weak var labelMenuCell: UILabel!
    @IBOutlet weak var labelDishMenu: UILabel!
    
    var menu: Menu? {
        didSet {
            labelMenuCell.text = menu?.name
            labelDishMenu.text = menu?.cook
            imageMenuCell.kf.indicatorType = .activity
            imageMenuCell.kf.setImage(with: URL(string: menu?.imageURL ?? "https://firebasestorage.googleapis.com/v0/b/mealschedule-58525.appspot.com/o/RecipesImages%2Fpizza.jpg?alt=media&token=3f0d2622-5157-4906-b9dc-331b07d9052f"))
        }
    }
}



