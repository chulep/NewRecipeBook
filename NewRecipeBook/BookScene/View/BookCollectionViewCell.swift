//
//  RecipeCollectionViewCell.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 05.01.2023.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    
    static let identifire = "recipeCell"
    
    //MARK: - UI Elements
    
    private var imageView: UIImageView = {
        $0.tintColor = ColorHelper.gray
        $0.backgroundColor = ColorHelper.lightGray
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    private var titleLabel: UILabel = {
        $0.textAlignment = .center
        $0.numberOfLines = 2
        return $0
    }(UILabel())
    
    //MARK: - LayoutSubviews
    
    override func layoutSubviews() {
        super.layoutSubviews()
        createUI()
    }
    
    //MARK: - Create UI
    
    private func createUI() {
        layer.cornerRadius = 10
        clipsToBounds = true
        backgroundColor = ColorHelper.babackgroundGrey
        
        addSubview(imageView)
        addSubview(titleLabel)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
            imageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 7),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -7),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    //MARK: - Set data
    
    func setData(title: String?, imageData: Data?) {
        titleLabel.text = title
        if imageData != nil {
            imageView.contentMode = .scaleAspectFill
            imageView.image = UIImage(data: imageData!)
        } else {
            imageView.contentMode = .scaleAspectFit
            imageView.image = UIImage(systemName: "camera")
        }
    }
    
}
