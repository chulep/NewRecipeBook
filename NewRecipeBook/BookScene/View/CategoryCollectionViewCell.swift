//
//  CategoryCollectionViewCell.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 31.01.2023.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    static let identifire = "categoryCell"
    
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
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.tintColor = ColorHelper.gray
        imageView.contentMode = .scaleAspectFit
        
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        self.backgroundColor = ColorHelper.babackgroundGrey
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            imageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            nameLabel.leftAnchor.constraint(equalTo: leftAnchor),
            nameLabel.rightAnchor.constraint(equalTo: rightAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setData(text: String?, imageData: Data?) {
        nameLabel.text = text
        if imageData != nil {
            imageView.image = UIImage(data: imageData!)
        } else {
            imageView.image = UIImage(systemName: "camera")
        }
    }
}
