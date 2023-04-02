//
//  FavoriteCollectionViewCell.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 23.03.2023.
//

import UIKit

class FavoriteCollectionViewCell: UICollectionViewCell {
    
    static let identifire = "favoriteCell"
    
    private var isSetImage = false
    
    //MARK: - UI Elements
    
    private var imageView: UIImageView = {
        $0.tintColor = ColorHelper.lightGray
        $0.backgroundColor = .clear
        return $0
    }(UIImageView())
    
    private var titleLabel: UILabel = {
        $0.textAlignment = .center
        $0.numberOfLines = 2
        return $0
    }(UILabel())
    
    private let lineView: UIView = {
        $0.backgroundColor = ColorHelper.gray
        return $0
    }(UIView())
    
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
        
        addSubview(lineView)
        addSubview(imageView)
        addSubview(titleLabel)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        lineView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(createImageViewConstraints(isSetImage: isSetImage))
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: bounds.width),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 7),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -7),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            lineView.heightAnchor.constraint(equalToConstant: 1),
            lineView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor),
            lineView.leftAnchor.constraint(equalTo: leftAnchor),
            lineView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
    
    private func createImageViewConstraints(isSetImage: Bool) -> [NSLayoutConstraint] {
        if isSetImage {
            return [
                imageView.topAnchor.constraint(equalTo: topAnchor),
                imageView.leftAnchor.constraint(equalTo: leftAnchor),
                imageView.rightAnchor.constraint(equalTo: rightAnchor),
                imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
            ]
        } else {
            return [
                imageView.topAnchor.constraint(equalTo: topAnchor, constant: 25),
                imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 25),
                imageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -25),
                imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
            ]
        }
    }
    
    //MARK: - Set data
    
    func setData(title: String?, imageData: Data?) {
        titleLabel.text = title
        if imageData != nil {
            isSetImage = true
            imageView.contentMode = .scaleAspectFill
            imageView.image = UIImage(data: imageData!)
        } else {
            imageView.contentMode = .scaleAspectFit
            imageView.image = (UIImage(named: "camera")?.withRenderingMode(.alwaysTemplate))
        }
    }
}
