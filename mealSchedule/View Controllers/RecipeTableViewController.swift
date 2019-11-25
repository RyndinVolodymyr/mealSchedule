//
//  RecipeTableViewController.swift
//  mealSchedule
//
//  Created by Владимир Рындин on 7/27/19.
//  Copyright © 2019 com.ryndinvi. All rights reserved.
//

import UIKit

class RecipeTableViewController: UITableViewController {

    let recipeNameArray = ["Похудение", "Норма", "Набор массы"]
    let recipeImageArray = [UIImage(named: "dieta"), UIImage(named: "norma"), UIImage(named: "nabor")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(ImageViewCell.self, forCellReuseIdentifier: "ImageViewCell")

    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showDetailVC", sender: self)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return recipeImageArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageViewCell") as! ImageViewCell
        cell.mainImageView.image = recipeImageArray[indexPath.row]
        cell.mainLabel.text = recipeNameArray[indexPath.row]
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let currentImage = recipeImageArray[indexPath.row]
        let imageCrop = currentImage!.getCropRatio()
        return tableView.frame.width / imageCrop
    }
}

extension UIImage {
    func getCropRatio() -> CGFloat {
        let widthRatio = CGFloat(self.size.width / self.size.height)
        return widthRatio
    }
}
