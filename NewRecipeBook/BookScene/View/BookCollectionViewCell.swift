//
//  RecipeCollectionViewCell.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 05.01.2023.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    
    static let identifire = "recipeCell"
    
    private var imageView = UIImageView()
    private var nameLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        createUI()
    }
    
    private func createUI() {
        addSubview(imageView)
        addSubview(nameLabel)
        
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 2
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.tintColor = ColorHelper.gray
        imageView.backgroundColor = ColorHelper.lightGray
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        self.backgroundColor = ColorHelper.babackgroundGrey
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
            imageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 7),
            nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -7),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setData(text: String?, imageData: Data?) {
        nameLabel.text = text
        if imageData != nil {
            imageView.contentMode = .scaleAspectFill
            imageView.image = UIImage(data: imageData!)
        } else {
            imageView.contentMode = .scaleAspectFit
            imageView.image = UIImage(systemName: "camera")
        }
    }
    
}
