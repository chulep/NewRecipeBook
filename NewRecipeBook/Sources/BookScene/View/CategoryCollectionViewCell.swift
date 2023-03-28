//
//  CategoryCollectionViewCell.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 31.01.2023.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    static let identifire = "categoryCell"
    
    //MARK: - UI Elements
    
    private var imageView: UIImageView = {
        $0.tintColor = ColorHelper.gray
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    private var titleLabel: UILabel = {
        $0.textAlignment = .center
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
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            imageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    //MARK: - Set data
    
    func setData(text: String?, imageData: Data?) {
        titleLabel.text = text
        if imageData != nil {
            imageView.image = UIImage(data: imageData!)
        } else {
            imageView.image = UIImage(systemName: "camera")
        }
    }
}
