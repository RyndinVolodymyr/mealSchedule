//
//  ImageTableViewCell.swift
//  
//
//  Created by Владимир Рындин on 7/27/19.
//

import UIKit

class ImageViewCell: UITableViewCell {
    
    var mainImageView: UIImageView = {
       var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var mainLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(30)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(mainImageView)
        self.addSubview(mainLabel)
        constraintForCellConfig()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func constraintForCellConfig() {
        mainLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        mainLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        mainLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        mainLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        mainImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        mainImageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        mainImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        mainImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
